//
//  other.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

// MARK: tableView
/*
 lazy var tableView: UITableView = {
 let t = UITableView(frame: CGRect.zero)
 t.separatorStyle = .none
 t.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
 t.showsVerticalScrollIndicator = true
 t.showsHorizontalScrollIndicator = true
 t.isPagingEnabled = true
 t.backgroundColor = UIColor.white
 t.delegate = self
 t.dataSource = self
 self.addSubview(t)
 
 t.ga.registerClassCell(CalendarCalendarCell.self)
 
 return t
 }()
 */
/*
 extension OWCalendarCalendarView: UITableViewDelegate, UITableViewDataSource {
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: kCalendarCalendarCell) as! CalendarCalendarCell
 cell.days = years[indexPath.row]
 return cell
 }
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return kOWCalendarCellHeight * 6.ga_CGFloat
 }
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return years.count
 }
 func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 let v = UILabel(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 20))
 if let m = month {
 v.text = m.year.ga_str + m.month.ga_str
 }
 v.backgroundColor = UIColor.orange
 return v
 }
 func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
 return 20
 }
 
 func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
 loadDays(tag: (scrollView.ga.offSetY / scrollView.ga_h).ga_Int)
 }
 }
 */
/*
 public let kCalendarCalendarCell = "CalendarCalendarCell"
 class CalendarCalendarCell: UITableViewCell {
 
 var days: [DayModel]? {
 didSet {
 collectionView.reloadData()
 }
 }
 
 lazy var collectionView: UICollectionView = {
 let c = UICollectionView(frame: self.bounds, collectionViewLayout: OWCalendarViewControllerLayout())
 c.isUserInteractionEnabled = true
 c.delegate = self
 c.dataSource = self
 c.bounces = false
 c.showsVerticalScrollIndicator = false
 c.showsHorizontalScrollIndicator = false
 c.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
 c.backgroundColor = UIColor.white
 c.ga.registerNibCell(kOWCalendarCell)
 self.addSubview(c)
 return c
 }()
 
 override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
 super.init(style: style, reuseIdentifier: reuseIdentifier)
 self.selectionStyle = .none
 
 setUI()
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 public func setUI() {
 collectionView.snp.makeConstraints { (make) in
 make.top.equalTo(0)
 make.left.right.equalTo(0)
 make.bottom.equalTo(0)
 }
 }
 }
 */
