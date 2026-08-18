import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { CommonSingleType } from '../main/ets/entity/constraints';

type CommonSingleTypeExpected = object | string | number | boolean | null | undefined;

// Compile-time contract: CommonSingleType must be TypeScript primitives, not boxed wrappers.
type Equal<A, B> =
  (<T>() => T extends A ? 1 : 2) extends
  (<T>() => T extends B ? 1 : 2) ? true : false;
type AssertTrue<T extends true> = T;
type _CommonSingleTypeContract = AssertTrue<Equal<CommonSingleType, CommonSingleTypeExpected>>;

export default function localUnitTest() {
  describe('localUnitTest',() => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    });
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    });
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    });
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });
    it('assertContain', 0, () => {
      // Defines a test case. This API supports three parameters: test case name, filter parameter, and test case function.
      let a = 'abc';
      let b = 'b';
      // Defines a variety of assertion methods, which are used to declare expected boolean conditions.
      expect(a).assertContain(b);
      expect(a).assertEqual(a);
    });
    it('commonSingleTypeUsesPrimitives', 0, () => {
      const contract: _CommonSingleTypeContract = true;
      const samples: CommonSingleTypeExpected[] = [{}, 'text', 1, true, null, undefined];
      const asCommonSingleType: CommonSingleType[] = samples;
      expect(contract).assertEqual(true);
      expect(asCommonSingleType.length).assertEqual(6);
    });
  });
}