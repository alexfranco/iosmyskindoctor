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
	@IBOutlet weak var timePicker: UIDatePicker!
	@IBOutlet weak var monthLabel: UILabel!
	
	var viewModelCast: BookingAConsultCalendarViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initViewModel(viewModel: BookingAConsultCalendarViewModel())
		
		configureCalendarView()
		configureTimePicker()
		applyTheme()
		
	}
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! BookingAConsultCalendarViewModel
		
		viewModelCast.selectedDateUpdated = { [weak self] (date) in
			DispatchQueue.main.async {
				self?.monthLabel.text = self?.viewModelCast.monthLabelText()
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
	}
	
	func configureCalendarView() {
		menuView.delegate = self
		calendarView.delegate = self
		calendarView.calendarAppearanceDelegate = self
	}
	
	func configureTimePicker() {
		timePicker.datePickerMode = .time
		timePicker.addTarget(self, action: #selector(BookAConsultCalendarViewController.timeChanged), for: UIControlEvents.valueChanged)
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
	
	@objc func timeChanged(sender: UIDatePicker) {
		viewModelCast.selectedDate = viewModelCast.selectedDate.adjust(hour: timePicker.date.component(.hour), minute: timePicker.date.component(.minute), second: timePicker.date.component(.second))
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToConfirmConsult {
			if let dest = segue.destination as? BookAConsultConfirmViewController, let model = viewModelCast.model {
				dest.initViewModel(viewModel: BookAConsultConfirmViewModel(model:  model))
			}
		}
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
		return AppStyle.consultCalendarFont!
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
			viewModelCast.selectedDate = (convertedDate.adjust(hour: timePicker.date.component(.hour), minute: timePicker.date.component(.minute), second: timePicker.date.component(.second)))
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

