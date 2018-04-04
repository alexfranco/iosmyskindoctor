//
//  BookAConsultCalendarViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar

class BookAConsultCalendarViewController: BindingViewController {
	
	@IBOutlet weak var pickATimeLabel: UILabel!
	@IBOutlet weak var pickADateLabel: UILabel!
	@IBOutlet weak var menuView: CVCalendarMenuView!
	@IBOutlet weak var calendarView: CVCalendarView!
	@IBOutlet weak var timeslotsPicker: UIPickerView!
	@IBOutlet weak var monthLabel: UILabel!
	@IBOutlet weak var noTimeslotsLabel: UILabel!
	
	var viewModelCast: BookAConsultCalendarViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initViewModel(viewModel: BookAConsultCalendarViewModel())
		
		configureCalendarView()
		configureTimeslotsPicker()
		applyTheme()
		applyLocalization()
		
		nextButton.isEnabled = viewModelCast.isNextButtonEnabled
		timeslotsPicker.isHidden = viewModelCast.shouldShowEmptyTimeSlotsLabel
		noTimeslotsLabel.isHidden = !viewModelCast.shouldShowEmptyTimeSlotsLabel
	}
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! BookAConsultCalendarViewModel
		
		viewModelCast.nextButtonUpdate = { [weak self] (show) in
			DispatchQueue.main.async {
				self?.nextButton.isEnabled = show
			}
		}
		
		viewModelCast.selectedDateUpdated = { [weak self] (date) in
			DispatchQueue.main.async {
				self?.monthLabel.text = self?.viewModelCast.monthLabelText
			}
		}
		
		viewModelCast.timeslotsUpdated = { [weak self] () in
			DispatchQueue.main.async {
				self?.timeslotsPicker.reloadAllComponents()
				self?.timeslotsPicker.isHidden = (self?.viewModelCast.shouldShowEmptyTimeSlotsLabel)!
				self?.noTimeslotsLabel.isHidden = !(self?.viewModelCast.shouldShowEmptyTimeSlotsLabel)!
			}
		}
		
		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.goToConfirmConsult, sender: nil)
			}
		}
	}
	
	func applyTheme() {
		nextButton.backgroundColor = AppStyle.consultNextButtonBackgroundColor
		
		menuView.backgroundColor = UIColor.clear
		calendarView.backgroundColor = UIColor.clear
		
		pickADateLabel.backgroundColor = AppStyle.consultCalendarHeaderBackgroundColor
		pickADateLabel.textColor = AppStyle.consultCalendarHeaderTextColor
		pickATimeLabel.backgroundColor = AppStyle.consultCalendarHeaderBackgroundColor
		pickATimeLabel.textColor = AppStyle.consultCalendarHeaderTextColor
		
		noTimeslotsLabel.font = AppFonts.bigBoldFont
		
		noTimeslotsLabel.isHidden = false
		timeslotsPicker.isHidden = true
	}
	
	func applyLocalization() {
		title = NSLocalizedString("booking_calendar_vc_title", comment: "")
		pickADateLabel.text = NSLocalizedString("booking_calendar_pick_a_date", comment: "")
		pickATimeLabel.text = NSLocalizedString("booking_calendar_pick_a_time", comment: "")
		noTimeslotsLabel.text = NSLocalizedString("booking_calendar_timeslot_emtpy", comment: "")
	}
	
	func configureCalendarView() {
		menuView.delegate = self
		calendarView.delegate = self
		calendarView.calendarAppearanceDelegate = self
	}
	
	func configureTimeslotsPicker() {
		timeslotsPicker.delegate = self
		timeslotsPicker.dataSource = self
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		menuView.commitMenuViewUpdate()
		calendarView.commitCalendarViewUpdate()
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToConfirmConsult {
			if let dest = segue.destination as? BookAConsultConfirmViewController {
				dest.initViewModel(viewModel: BookAConsultConfirmViewModel(selectedDate: viewModelCast.selectedDate))
			}
		}
	}
}

extension BookAConsultCalendarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return viewModelCast.numberOfComponentsInPickerView
	}
	
	// The number of rows of data
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return viewModelCast.numberOfItems
	}
	
	// The data to return for the row and component (column) that's being passed in
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return viewModelCast.getItemAtIndexPath(row).timeslotDisplayText
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		viewModelCast.selectedDate = viewModelCast.getItemAtIndexPath(row).date
	}
}

extension BookAConsultCalendarViewController: CVCalendarMenuViewDelegate, CVCalendarViewDelegate {
	// MARK: CVCalendarMenuViewDelegate
	
	@objc func dayOfWeekBackGroundColor(by weekday: Weekday) -> UIColor {
		return UIColor.clear
	}
	
	@objc func dayOfWeekTextColor() -> UIColor {
		return UIColor.black
	}
	
	func dayOfWeekFont() -> UIFont {
		return AppStyle.consultCalendarFont
	}
	
	func weekdaySymbolType() -> WeekdaySymbolType {
		return WeekdaySymbolType.veryShort
	}
	
	// MARL: CVCalendarViewDelegate
	
	func presentationMode() -> CalendarMode {
		return CalendarMode.monthView
	}
	
	func firstWeekday() -> Weekday {
		return Weekday.monday
	}
	
	func shouldShowWeekdaysOut() -> Bool {
		return true
	}
	
	func earliestSelectableDate() -> Date {
		return Date().adjust(.day, offset: -1)
	}
	
	func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
		if let dateSafe = dayView.date, let convertedDate = dateSafe.convertedDate() {
			viewModelCast.selectedDate = convertedDate
			viewModelCast.fetchTimeslots()
		}
	}
}

extension BookAConsultCalendarViewController: CVCalendarViewAppearanceDelegate {
	
	func dayLabelPresentWeekdayTextColor() -> UIColor {
		return AppStyle.consultCalendarPresentTextColor
	}
	
	func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
		return AppStyle.consultCalendarPresentBackgroundColor
	}
	
	func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
		switch (weekDay, status, present) {
		case (_, .selected, _), (_, .highlighted, _): return AppStyle.consultCalendarSelectedDayTextColor
		case (_, .in, _): return AppStyle.consultCalendarDayTextColor
		default: return nil
		}
	}
	
	func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
		switch (weekDay, status, present) {
		case (_, .selected, _), (_, .highlighted, _): return AppStyle.consultCalendarSelectedDayBackgroundColor
		default: return AppStyle.consultCalendarDayBackgroundColor
		}
	}
	
}

