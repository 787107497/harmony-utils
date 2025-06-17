/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { ObserverWrapper } from '../core/LiveEvent';

import Observer from "./Observer";

/**
 * Data holder that observers changes in state.
 */
abstract class LiveData<T> {
    protected observers: Array<Observer<T>> = []

    protected data: T | null = null

    /**
     * Observes changes in LiveData value. If value set before observed, immediately invokes observer.
     *
     * @param observer  The observer to watch for changes.
     */
    public observe(observer: Observer<T>) {
        this.observers.push(observer)
        const tData = this.data
        if (tData != null) observer.onChanged(tData)
    }

    /**
     * @return  The current LiveData value.
     */
    public getValue(): T | null {
        return this.data
    }

    /**
     * Attempts to remove observer.
     *
     * @param observer  The observer to remove.
     *
     * @return  True if removed otherwise false.
     */
    public removeObserver(observer: Observer<T>): boolean {
        for (let i = 0; i < this.observers.length; i++) {
            const currentObserver = this.observers[i];
            if (
                (currentObserver instanceof ObserverWrapper && currentObserver.getObserver() === observer) ||
                    (currentObserver === observer)
            ) {
                this.observers.splice(i, 1);
                return true;
            }
        }
        return false;
    }

    /**
     * Removes all observers.
     */
    public removeAllObservers() {
        this.observers.splice(0, this.observers.length)
    }

    /**
     * @return  A read-only version of observers.
     *          Mostly used for testing.
     */
    getObservers(): ReadonlyArray<Observer<T>> {
        return this.observers
    }
}

export default LiveData