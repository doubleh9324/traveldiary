package wpjsp.model;

import java.util.List;

public class JournalListView {

	private int journalTotalCount;
	private int currentPageNumber;
	private List<Bulletin> journalList;
	private int pageTotalCount;
	private int journalCountPerPage;
	private int firstRow;
	private int endRow;

	
	public JournalListView(List<Bulletin> journalList,
			int journalTotalCount,		
			int currentPageNumber,		
			int journalCountPerPage,	 
			int startRow,
			int endRow) 
	{
		this.journalList = journalList;
		this.journalTotalCount = journalTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.journalCountPerPage = journalCountPerPage;
		this.firstRow = startRow;
		this.endRow = endRow;

		calculatePageTotalCount();
	}

	private void calculatePageTotalCount() {
		if (journalTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = journalTotalCount / journalCountPerPage;
			if (journalTotalCount % journalCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}

	public int getJournalTotalCount() {
		return journalTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public List<Bulletin> getJournalList() {
		return journalList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getJournalCountPerPage() {
		return journalCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public boolean isEmpty() {
		return journalTotalCount == 0;
	}
}
