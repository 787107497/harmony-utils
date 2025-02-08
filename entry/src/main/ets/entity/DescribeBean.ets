export class DescribeBean {
  name: string = '';
  desc: string = '';
  type: number = 0; //0-测试页面、1-util、2-crypto
  example: string = ''; //案例地址
  code: string = ''; //源代码地址
  url: string = ''; //url地址


  constructor(name: string, desc: string, type: number = 0) {
    this.name = name;
    this.desc = desc;
    this.type = type;
  }

}