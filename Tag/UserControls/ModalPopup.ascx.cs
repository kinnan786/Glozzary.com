using System;
using System.Web.UI;

namespace Tag.UserControls
{
    public partial class ModalPopup : UserControl
    {
        private string _modalPopupTitle;

        public string ModalPopupWidth
        {
            set {
                modalPopupWidth = string.IsNullOrEmpty(value) ? "100" : value;
            }
            get { return modalPopupWidth; }
        }

        public string ModalPopupHeight
        {
            set {
                modalPopupHeight = string.IsNullOrEmpty(value) ? "100" : value;
            }
            get { return modalPopupHeight; }
        }

        public string ModalPopupSrc { get; set; }

        public string ModalPopupTitle
        {
            set {
                _modalPopupTitle = string.IsNullOrEmpty(value) ? "No Title" : value;
            }
            get { return _modalPopupTitle; }
        }

        public string ModalPopupButtonId { get; set; }

        public string IframeName { get; set; }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ModalPopupWidth))
                ModalPopupWidth = "500";

            if (string.IsNullOrEmpty(ModalPopupHeight))
                ModalPopupHeight = "700";

            ltrliframe.Text = "<iframe id='" + IframeName +
                              "' clientidmode='Static'  style=' overflow: auto;width:700px;height:500px;' frameborder='0' scrolling='auto' scrollbar='no' runat='server' src='" +
                              ModalPopupSrc + "' class='iframeclass'></iframe>";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lbltitle.Text = ModalPopupTitle;
        }

        protected void Page_Init(object sender, EventArgs e)
        {
        }

        protected void Page_UnLoad(object sender, EventArgs e)
        {
        }
    }
}