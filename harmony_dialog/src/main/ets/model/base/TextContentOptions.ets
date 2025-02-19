
@Observed
export class TextContentOptions {
  constructor(themeColorMode: ThemeColorMode, primaryTitle: ResourceStr, secondaryTitle: ResourceStr,
    contentAreaPadding: Padding, localizedContentAreaPadding: LocalizedPadding,
    buttons: Array<ResourceStr | ButtonOptions>, contentBuilder: () => void) {
    this.themeColorMode = themeColorMode;
    this.primaryTitle = primaryTitle;
    this.secondaryTitle = secondaryTitle;
    this.contentBuilder = contentBuilder;
    this.contentAreaPadding = contentAreaPadding;
    this.localizedContentAreaPadding = localizedContentAreaPadding;
    this.buttons = buttons;
  }


  themeColorMode?: ThemeColorMode;
  primaryTitle?: ResourceStr;
  secondaryTitle?: ResourceStr;
  contentBuilder?: () => void;
  contentAreaPadding?: Padding;
  localizedContentAreaPadding?: LocalizedPadding;
  buttons?: Array<ResourceStr | ButtonOptions>;

}