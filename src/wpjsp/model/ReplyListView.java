package wpjsp.model;

import java.util.List;

public class ReplyListView {
	
	private int replyTotalCount;
	private int currentPageNumber;
	private List<Reply> replyList;
	private int pageTotalCount;
	private int replyCountPerPage;
	private int firstRow;
	private int endRow;
	
	public ReplyListView(List<Reply> replyList, 
			int replyTotalCount,
			int currentPageNumber,
			int replyCountPerPage,
			int startRow,
			int endRow)
	{
		this.replyList = replyList;
		this.replyTotalCount = replyTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.replyCountPerPage = replyCountPerPage;
		this.firstRow = startRow;
		this.endRow = endRow;
		
		calculatePageTotalCount();
	}
	
	private void calculatePageTotalCount(){
		if(replyTotalCount == 0){
			pageTotalCount = 0;
		} else {
			pageTotalCount = replyTotalCount / replyCountPerPage;
			if(replyTotalCount % replyCountPerPage > 0){
				pageTotalCount++;
			}
		}
	}
	
	public int getReplyTotalCount(){
		return this.replyTotalCount;
	}
	
	public int getCurrentPageNumber(){
		return this.currentPageNumber;
	}
	
	public List<Reply> getReplyList(){
		return this.replyList;
	}
	
	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getReplyCountPerPage() {
		return replyCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public boolean isEmpty() {
		return replyTotalCount == 0;
	}

}
