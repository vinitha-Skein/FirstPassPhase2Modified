//
//  ReportsViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 21/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

struct ReportData {
    let name:String
    let doc:String
}

import UIKit
import QuickLook
class ReportsViewController: UIViewController,ReportDelegate
{
 
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var reportCountLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet var bgView: UIView!
    
   // @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var container: UIView!
    var isNeedBackButton = false
    lazy var previewItem = NSURL()
    var reportData = [ReportData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableview.register(UINib(nibName: "ReportsTableViewCell", bundle: .main), forCellReuseIdentifier: "ReportsTableViewCell")
        filterTableview.register(UINib(nibName: "FilterTableViewCell", bundle: .main), forCellReuseIdentifier: "FilterTableViewCell")
        let nib = UINib(nibName: "ReportHeader", bundle: nil)
        tableview.register(nib, forHeaderFooterViewReuseIdentifier: "ReportHeader")
        tableview.dataSource = self
        tableview.delegate = self
        filterTableview.dataSource = self
        filterTableview.delegate = self
        
        reportData = [ReportData(name: "CBP Test", doc: "GlucoseReport.doc"),ReportData(name: "Blood Test", doc: "GrowthHarmoneReport.doc"),ReportData(name: "Diabetes Test", doc: "GlucoseReport.doc"),ReportData(name: "CBP Test", doc: "GlucoseReport.doc"),ReportData(name: "Blood Test", doc: "GlucoseReport.doc"),ReportData(name: "Diabetes Test", doc: "GlucoseReport.doc"),ReportData(name: "CBP Test", doc: "GlucoseReport.doc")]
        
//        if isNeedBackButton{
//            backButton.isHidden = false
//        }else{
//            backButton.isHidden = true
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        vipview()
    }
    func vipview()
    {
        bgView.backgroundColor = UIColor.black
        container.backgroundColor = UIColor(hex: "#222629")
        titleLabel.textColor = UIColor.white
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
        reportCountLabel.textColor = UIColor(named: "vip")
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterAction(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReportsFilterViewController") as! ReportsFilterViewController
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
//        createFilterView()
    }
    func setupUI(){
//        scannerButton.createCircle()
//        profileButton.createCircle()
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        container.layer.borderWidth = 0.4
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        
    }
    func viewReport(index: Int) {
        let previewController = QLPreviewController()
        // Set the preview item to display
        self.previewItem = self.getPreviewItem(withName: reportData[index].doc)

        previewController.dataSource = self
        self.present(previewController, animated: true, completion: nil)
    }
    func getPreviewItem(withName name: String) -> NSURL{

        //  Code to diplay file from the app bundle
        let file = name.components(separatedBy: ".")
        let path = Bundle.main.path(forResource: file.first!, ofType: file.last!)
        let url = NSURL(fileURLWithPath: path!)

        return url
    }
    
    //Create Blur background
    func createBlurView(){
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = UIColor.black
        blurView.alpha = 0.6
        view.addSubview(blurView)
        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        blurView.isUserInteractionEnabled = true
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
        //        blurView.addGestureRecognizer(gesture)
    }
    
    var doneButton = UIButton()
    var blurView = UIView()
    var filterContainer = UIView()
    var filterTableview = UITableView()
    var filterTitle = UILabel()
    var clearButton = UIButton()
    var filterList = [String]()
    func createFilterView(){
        createBlurView()
        doneButton.layer.cornerRadius = 8
        doneButton.backgroundColor = UIColor.white
        view.addSubview(doneButton)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        
        view.addSubview(filterContainer)
        filterContainer.backgroundColor = UIColor.white
        filterContainer.layer.cornerRadius = 16
        filterContainer.translatesAutoresizingMaskIntoConstraints = false
        filterContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        filterContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        filterContainer.bottomAnchor.constraint(equalTo: doneButton.topAnchor,constant: -20).isActive = true
        filterContainer.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        filterTitle.text = "Filter"
        filterTitle.clipsToBounds = true
        filterTitle.textAlignment = .center
        filterTitle.backgroundColor = UIColor.white
        filterContainer.addSubview(filterTitle)
        filterTitle.layer.cornerRadius = 16
        filterTitle.translatesAutoresizingMaskIntoConstraints = false
        filterTitle.leadingAnchor.constraint(equalTo: filterContainer.leadingAnchor,constant: 0).isActive = true
        filterTitle.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor,constant: 0).isActive = true
        //        filterTitle.bottomAnchor.constraint(equalTo: filterTableview.topAnchor,constant: -20).isActive = true
        filterTitle.topAnchor.constraint(equalTo: filterContainer.topAnchor,constant: 0).isActive = true
        filterTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        filterContainer.addSubview(filterTableview)
        filterTableview.backgroundColor = UIColor.white
        filterTableview.layer.cornerRadius = 16
        filterTableview.translatesAutoresizingMaskIntoConstraints = false
        filterTableview.topAnchor.constraint(equalTo: filterTitle.bottomAnchor,constant: 0).isActive = true
        filterTableview.leadingAnchor.constraint(equalTo: filterContainer.leadingAnchor,constant: 0).isActive = true
        filterTableview.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor,constant:0).isActive = true
        filterTableview.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor,constant: 0).isActive = true
        
        filterContainer.addSubview(clearButton)
        clearButton.setTitle("Clear All", for: .normal)
        clearButton.setTitleColor(.blue, for: .normal)

        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor,constant:-20).isActive = true
        clearButton.centerYAnchor.constraint(equalTo: filterTitle.centerYAnchor,constant: 0).isActive = true
    }
    
    
}


extension ReportsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableview{
            return 50
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tableview
        {
            guard let view = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: "ReportHeader")
                as? ReportHeader
            else
            {
                return nil
            }
            if UserDefaults.standard.bool(forKey: "vip")
            {
                view.container.layer.cornerRadius = 10
                view.container.backgroundColor = UIColor(named: "vip")
                view.actionLabel.textColor = UIColor(named: "#503E00")
                view.dateLabel.textColor = UIColor(named: "#503E00")
                view.processLabel.textColor = UIColor(named: "#503E00")
            }
            else
            {
                view.container.layer.cornerRadius = 10
                view.container.backgroundColor = UIColor(hex: "#F8F8F9")
                view.actionLabel.textColor = UIColor.black
                view.dateLabel.textColor = UIColor.black
                view.processLabel.textColor = UIColor.black
            }
            
           
            
            return view
        }
        else
        {
            return nil
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableview{
            return reportData.count
        }else{
            return filterList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableview
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportsTableViewCell", for: indexPath) as! ReportsTableViewCell
            
            cell.delegate = self

            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.name.text = reportData[indexPath.row].name
                cell.name.textColor = .white
                cell.dateLabel.textColor = .white
            }
            else
            {
                cell.name.text = reportData[indexPath.row].name

            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
            cell.type.text = filterList[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableview{
            return 50
        }else{
            return 65
        }
        
    }
    
    
}
extension ReportsViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        return self.previewItem as QLPreviewItem
    }
}


protocol ReportDelegate {
    func viewReport(index:Int)
}
