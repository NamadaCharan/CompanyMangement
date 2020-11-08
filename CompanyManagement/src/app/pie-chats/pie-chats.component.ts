import { Component, OnInit, OnDestroy } from '@angular/core';
import { Chart } from 'chart.js';
import { CompanyService } from 'src/app/shared/company.service';
import { ActivatedRoute } from '@angular/router';
import { ProductDetailsForChat } from 'src/app/Models/ProductDetailsForChat';

@Component({
    selector: 'app-pie-chats',
    templateUrl: './pie-chats.component.html',
    styleUrls: ['./pie-chats.component.css']
})
export class PieChatsComponent implements OnInit,OnDestroy {
    ngOnDestroy() {
    this.companyService.datatoPopulate=[];
    this.companyService.labelsPresent=[];
    }

    constructor(public companyService: CompanyService,
         private route: ActivatedRoute) { }
    LineChart = [];
    PieChart = [];
    datatoPopulate = []
    labels = ['Tin', 'Copper', 'Gold', 'Silver'];
    labelsPresent = [];

    ngOnInit() {
        this.companyService.productDetailsForChat=[]
    }

    getProductInformation() {
        this.route.paramMap.subscribe(params => {
            let id = params.get('id');
            this.companyService.getProductDetailsForChat(id).subscribe(result => {
                let response = result as ProductDetailsForChat[];
                  this.companyService.productDetailsForChat = response;
                  this.setChats();
            })
        });
    }
    setChats() {
  
        if (this.companyService.productDetailsForChat['length'] != 0) {
            this.companyService.productDetailsForChat.forEach((element, index) => {
                if (element.productName === 'Tin' || element.productName === 'Copper' || element.productName === 'Gold' || element.productName === 'Silver') {
                    this.companyService.datatoPopulate.push(element.noOfItems);
                    this.companyService.labelsPresent.push(element.productName);
                }
                else {
                    this.labels.forEach(ele => {
                        if (ele === element.productName) {
                            this.companyService.datatoPopulate.push(0);
                            this.companyService.labelsPresent.push(ele);
                        }
                    });
                }

            }
            );
        }
        else {
            this.companyService.labelsPresent = this.labels;
            this.companyService.datatoPopulate = [0, 0, 0, 0]
        }
 
        this.LineChart = new Chart('lineChart', {
            type: 'line',
            data: {
                labels: this.companyService.labelsPresent,
                datasets: [{
                    label: 'Number of Items Sold by Product',
                    data: this.companyService.datatoPopulate,
                    fill: false,
                    lineTension: 0.1,
                    borderColor: "green",
                    borderWidth: 1
                }]
            },
            options: {
                title: {
                    text: "Line Chart",
                    display: true
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: false
                        }
                    }]
                }
            }
        });

        // pie chart:
        this.PieChart = new Chart('pieChart', {
            type: 'pie',
            data: {
                labels: this.companyService.labelsPresent,
                datasets: [{
                    label: 'Number of Items Sold by Product',
                    data: this.companyService.datatoPopulate,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                title: {
                    text: "Pie Chart",
                    display: true
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });

    }

    showGraph(){
        this.companyService.showGraph=true;
        this.getProductInformation();
    }
}