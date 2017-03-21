//
//  VacationImageCollectionViewController.swift
//  Vacation Spots
//
//  Created by Hayden Goldman on 3/20/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit


private let reuseIdentifier = "VacationImageCell"

class VacationImageCollectionViewController: UICollectionViewController, AddNewImageDelegate {

    var vacationImages = [VacationImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vacationImage = VacationImage()
        vacationImage.title = "New York"
        vacationImage.image = UIImage(named: "NewYork.jpg")
        
        vacationImages.append(vacationImage)
        
    }


    func addImageDidSave(imageTitle :String, image :UIImage) {
        let newVacationImage = VacationImage()
        newVacationImage.title = imageTitle
        newVacationImage.image = image
        
        self.vacationImages.append(newVacationImage)
        
        self.collectionView?.reloadData()
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddVacationImage" {
            
            let addImageVC = segue.destination as! AddImageViewController
            addImageVC.delegate = self
            
        }
        
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.vacationImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacationImageCell", for: indexPath) as! VacationImageCollectionViewCell
    
        // Configure the cell
        
        let vacationImage = self.vacationImages[indexPath.row]
        
        cell.vacationImageView.image = vacationImage.image
        cell.vacationTitleLabel.text = vacationImage.title
    
        return cell
    }


}
