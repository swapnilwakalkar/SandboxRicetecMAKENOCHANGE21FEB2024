public class LC_Cntrl {
    public String recordId { get; private set; }

    public LC_Cntrl() {
        // Get the record ID from the URL
        recordId = ApexPages.currentPage().getParameters().get('id');
    }
}