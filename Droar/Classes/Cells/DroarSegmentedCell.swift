//
//  DroarSegmentedCell.swift
//  Droar
//
//  Created by Nathan Jangula on 10/26/17.
//

import Foundation

public class DroarSegmentedCell : UITableViewCell, DroarCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var onValueChanged: ((Int) -> Void)?
    
    public static func create(title: String? = "", values:[String] = [], defaultIndex:Int? = nil, allowSelection: Bool = false, onValueChanged: ((Int) -> Void)? = nil) -> DroarSegmentedCell {
        var cell: DroarSegmentedCell?
        
        for view in Bundle.podBundle.loadNibNamed("DroarSegmentedCell", owner: self, options: nil) ?? [Any]() {
            if view is DroarSegmentedCell {
                cell = view as? DroarSegmentedCell
            }
        }
        
        cell?.titleLabel.text = title
        cell?.segmentedControl.removeAllSegments()
        for value in values {
            cell?.segmentedControl.insertSegment(withTitle: value, at: values.index(of: value)!, animated: false)
        }
        if let defaultIndex = defaultIndex {
            cell?.segmentedControl.selectedSegmentIndex = defaultIndex
        }
        cell?.selectionStyle = allowSelection ? .gray : .none
        cell?.onValueChanged = onValueChanged
        
        return cell ?? DroarSegmentedCell()
    }
    
    @IBAction func handleValueChanged(_ sender: Any) {
        guard let onValueChanged = onValueChanged else { return }
        onValueChanged(segmentedControl.selectedSegmentIndex)
    }
    
    public func stateDump() -> [String : String]? {
        guard let text = titleLabel.text, let value = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) else { return nil }
        return [text : value]
    }
}