export class DescribeBean {
  name: string = '';
  desc: string = '';
  type: number = 0; //0-测试页面、1-util、2-crypto

  constructor(name: string, desc: string, type: number = 0) {
    this.name = name;
    this.desc = desc;
    this.type = type;
  }

}