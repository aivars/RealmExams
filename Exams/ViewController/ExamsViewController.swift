/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import RealmSwift

class ExamsViewController: UIViewController {

  let formatter: NSDateFormatter = {
    let f = NSDateFormatter()
    f.dateStyle = .MediumStyle
    f.timeStyle = .NoStyle
    return f
  }()

  @IBOutlet weak var tableView: UITableView!

  var exams: Results<Exam>?

  override func viewDidLoad() {
    let realm = try! Realm(configuration: RealmConfig.Main.configuration)
    exams = realm.objects(Exam).sorted("date", ascending: false)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
}

extension ExamsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return exams?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let exam = exams![indexPath.row]

    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
    cell.textLabel!.text = exam.name
    cell.textLabel!.textColor = UIColor.blueColor()

    cell.detailTextLabel!.text = formatter.stringFromDate(exam.date!)
    return cell
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let count = self.tableView(tableView, numberOfRowsInSection: section)
    return "\(count) exams this semester"
  }
}

extension ExamsViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}