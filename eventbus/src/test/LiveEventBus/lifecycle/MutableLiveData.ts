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


import LiveData from "./LiveData";

/**
 * Basic mutable instance of a {@link LiveData}.
 */
class MutableLiveData<T> extends LiveData<T> {

    /**
     * Sets current LiveData value, and notifies observers.
     *
     * @param value The value to set.
     */
    public postValue(value: T) {
        this.data = value
        this.observers.forEach(observer => {
            observer.onChanged(value)
        })
    }

}

export default MutableLiveData