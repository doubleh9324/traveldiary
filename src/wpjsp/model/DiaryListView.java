package wpjsp.model;

import java.util.List;

public class DiaryListView {
	
	private int diaryTotalCount;
	private int currentPageNumber;
	private List<Diary> diaryList;
	private int pageTotalCount;
	private int diaryCountPerPage;
	private int firstRow;
	private int endRow;

	
	public DiaryListView(List<Diary> diaryList,
			int diaryTotalCount,		
			int currentPageNumber,		
			int diaryCountPerPage,	 
			int startRow,
			int endRow) 
	{
		this.diaryList = diaryList;
		this.diaryTotalCount = diaryTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.diaryCountPerPage = diaryCountPerPage;
		this.firstRow = startRow;
		this.endRow = endRow;

		calculatePageTotalCount();
	}

	private void calculatePageTotalCount() {
		if (diaryTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = diaryTotalCount / diaryCountPerPage;
			if (diaryTotalCount % diaryCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}

	public int getDiaryTotalCount() {
		return diaryTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}
	
	public List<Diary> getDiaryList(){
		return diaryList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getDiaryCountPerPage() {
		return diaryCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public boolean isEmpty() {
		return diaryTotalCount == 0;
	}

}
