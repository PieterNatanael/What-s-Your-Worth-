//
//  ContentView.swift
//  What’s Your Worth?
//
//  Created by Pieter Yoshua Natanael on 25/05/24.
//


//the app with collaboration with Alan Theo

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var valuationDate = Date()
    @State private var name = ""
    @State private var country = ""
    @State private var currency = ""
    
    // Ads and app functionality
    @State private var showAdsAndAppFunctionality = false
    
    // Expenses
    @State private var finalExpenses = ""
    @State private var taxesPayable = ""
    @State private var mortgageRetirement = ""
    @State private var otherDebt = ""
    @State private var educationFund = ""
    @State private var emergencyFund = ""
    @State private var otherExpenses = ""
    
    // Living Expenses Annually
    @State private var spouseLivingExpenses = ""
    @State private var child1LivingExpenses = ""
    @State private var child2LivingExpenses = ""
    @State private var parent1LivingExpenses = ""
    @State private var parent2LivingExpenses = ""
    @State private var otherLivingExpenses = ""
    
    // Dependent Age
    @State private var spouseAge = ""
    @State private var child1Age = ""
    @State private var child2Age = ""
    @State private var parent1Age = ""
    @State private var parent2Age = ""
    @State private var otherDependentAge = ""
    
    // Employment Income
    @State private var spouseEmploymentIncome = ""
    
    // Portfolio
    @State private var cashSavings = ""
    @State private var vestedRetirementAccounts = ""
    @State private var lifeInsurance = ""
    @State private var property = ""
    
    // Other Assets
    @State private var investmentPortfolioEquity = ""
    @State private var investmentPortfolioBonds = ""
    
    // Calculation Results
    @State private var lifeInsuranceRequirement: Double?
    @State private var netWorth: Double?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Valuation Date")) {
                    DatePicker("Date", selection: $valuationDate, displayedComponents: .date)
                }
                
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Country", text: $country)
                    TextField("Currency", text: $currency)
                }
                
                Section(header: Text("Expenses")) {
                    TextField("Final Expenses", text: $finalExpenses).keyboardType(.decimalPad)
                    TextField("Taxes Payable", text: $taxesPayable).keyboardType(.decimalPad)
                    TextField("Mortgage Retirement", text: $mortgageRetirement).keyboardType(.decimalPad)
                    TextField("Other Debt", text: $otherDebt).keyboardType(.decimalPad)
                    TextField("Education Fund", text: $educationFund).keyboardType(.decimalPad)
                    TextField("Emergency Fund", text: $emergencyFund).keyboardType(.decimalPad)
                    TextField("Other Expenses", text: $otherExpenses).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Living Expenses Annually")) {
                    TextField("Spouse", text: $spouseLivingExpenses).keyboardType(.decimalPad)
                    TextField("Child 1", text: $child1LivingExpenses).keyboardType(.decimalPad)
                    TextField("Child 2", text: $child2LivingExpenses).keyboardType(.decimalPad)
                    TextField("Parent 1", text: $parent1LivingExpenses).keyboardType(.decimalPad)
                    TextField("Parent 2", text: $parent2LivingExpenses).keyboardType(.decimalPad)
                    TextField("Other", text: $otherLivingExpenses).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Dependent Age")) {
                    TextField("Spouse", text: $spouseAge).keyboardType(.decimalPad)
                    TextField("Child 1", text: $child1Age).keyboardType(.decimalPad)
                    TextField("Child 2", text: $child2Age).keyboardType(.decimalPad)
                    TextField("Parent 1", text: $parent1Age).keyboardType(.decimalPad)
                    TextField("Parent 2", text: $parent2Age).keyboardType(.decimalPad)
                    TextField("Other", text: $otherDependentAge).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Employment Income")) {
                    TextField("Spouse", text: $spouseEmploymentIncome).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Portfolio")) {
                    TextField("Cash and Savings", text: $cashSavings).keyboardType(.decimalPad)
                    TextField("Vested Retirement Accounts", text: $vestedRetirementAccounts).keyboardType(.decimalPad)
                    TextField("Life Insurance", text: $lifeInsurance).keyboardType(.decimalPad)
                    TextField("Property", text: $property).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Other Assets")) {
                    TextField("Investment Portfolio - Equity", text: $investmentPortfolioEquity).keyboardType(.decimalPad)
                    TextField("Investment Portfolio - Bonds", text: $investmentPortfolioBonds).keyboardType(.decimalPad)
                }
                
                Section {
                    Button(action: calculateRequirements) {
                        Text("Calculate Requirements")
                    }
                    
                    Button(action: exportData) {
                        Text("Export Data")
                    }
                }
                
                if let requirement = lifeInsuranceRequirement {
                    Section(header: Text("Valuation Output")) {
                        Text("Life Insurance Required: \(currency) \(requirement, specifier: "%.2f")")
                    }
                }
                
                if let worth = netWorth {
                    Section(header: Text("Net Worth")) {
                        Text("Net Worth: \(currency) \(worth, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarItems(leading:
                HStack {
                    Text("What's Your Worth?")
                        .font(.title2)
                    Spacer()
                    Button(action: {
                        showAdsAndAppFunctionality = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(.white))
                            .padding()
                            .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 2)
                    }
                }
            )
            .font(.title3)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showAdsAndAppFunctionality) {
            ShowAdsAndAppFunctionalityView(onConfirm: {
                showAdsAndAppFunctionality = false
            })
        }
    }
    
    func calculateRequirements() {
        // Parsing inputs to Double
        let finalExpensesValue = Double(finalExpenses) ?? 0.0
        let taxesPayableValue = Double(taxesPayable) ?? 0.0
        let mortgageRetirementValue = Double(mortgageRetirement) ?? 0.0
        let otherDebtValue = Double(otherDebt) ?? 0.0
        let educationFundValue = Double(educationFund) ?? 0.0
        let emergencyFundValue = Double(emergencyFund) ?? 0.0
        let otherExpensesValue = Double(otherExpenses) ?? 0.0
        
        let spouseLivingExpensesValue = Double(spouseLivingExpenses) ?? 0.0
        let child1LivingExpensesValue = Double(child1LivingExpenses) ?? 0.0
        let child2LivingExpensesValue = Double(child2LivingExpenses) ?? 0.0
        let parent1LivingExpensesValue = Double(parent1LivingExpenses) ?? 0.0
        let parent2LivingExpensesValue = Double(parent2LivingExpenses) ?? 0.0
        let otherLivingExpensesValue = Double(otherLivingExpenses) ?? 0.0
        
        let cashSavingsValue = Double(cashSavings) ?? 0.0
        let vestedRetirementAccountsValue = Double(vestedRetirementAccounts) ?? 0.0
        let lifeInsuranceValue = Double(lifeInsurance) ?? 0.0
        let propertyValue = Double(property) ?? 0.0
        
        let investmentPortfolioEquityValue = Double(investmentPortfolioEquity) ?? 0.0
        let investmentPortfolioBondsValue = Double(investmentPortfolioBonds) ?? 0.0
        
        // Calculate total expenses
        let totalExpenses = finalExpensesValue + taxesPayableValue + mortgageRetirementValue + otherDebtValue + educationFundValue + emergencyFundValue + otherExpensesValue
        
        // Calculate living expenses over the years
        let yearsToRetirement = 65 - (Double(spouseAge) ?? 0.0)
        let spouseLivingExpensesTotal = spouseLivingExpensesValue * yearsToRetirement
        
        let child1LivingExpensesTotal = child1LivingExpensesValue * max(21 - (Double(child1Age) ?? 0.0), 0)
        let child2LivingExpensesTotal = child2LivingExpensesValue * max(21 - (Double(child2Age) ?? 0.0), 0)
        
        let parent1LivingExpensesTotal = parent1LivingExpensesValue * max(85 - (Double(parent1Age) ?? 0.0), 0)
        let parent2LivingExpensesTotal = parent2LivingExpensesValue * max(85 - (Double(parent2Age) ?? 0.0), 0)
        
        let otherLivingExpensesTotal = otherLivingExpensesValue * max(21 - (Double(otherDependentAge) ?? 0.0), 0)
        
        let totalLivingExpenses = spouseLivingExpensesTotal + child1LivingExpensesTotal + child2LivingExpensesTotal + parent1LivingExpensesTotal + parent2LivingExpensesTotal + otherLivingExpensesTotal
        
        // Calculate total assets
        let totalAssets = cashSavingsValue + vestedRetirementAccountsValue + lifeInsuranceValue + propertyValue + investmentPortfolioEquityValue + investmentPortfolioBondsValue
        
        // Calculate life insurance requirement
        lifeInsuranceRequirement = totalExpenses + totalLivingExpenses - totalAssets
        
        // Calculate net worth
        netWorth = (cashSavingsValue + vestedRetirementAccountsValue + propertyValue + investmentPortfolioEquityValue + investmentPortfolioBondsValue) - (finalExpensesValue + taxesPayableValue + mortgageRetirementValue + otherDebtValue + otherExpensesValue)
    }
    
    func exportData() {
        let fileName = "InsuranceCalculation.txt"
        let fileContents = """
        Valuation Date: \(valuationDate)
        Name: \(name)
        Country: \(country)
        Currency: \(currency)
        
        Final Expenses: \(finalExpenses)
        Taxes Payable: \(taxesPayable)
        Mortgage Retirement: \(mortgageRetirement)
        Other Debt: \(otherDebt)
        Education Fund: \(educationFund)
        Emergency Fund: \(emergencyFund)
        Other Expenses: \(otherExpenses)
        
        Spouse Living Expenses: \(spouseLivingExpenses)
        Child 1 Living Expenses: \(child1LivingExpenses)
        Child 2 Living Expenses: \(child2LivingExpenses)
        Parent 1 Living Expenses: \(parent1LivingExpenses)
        Parent 2 Living Expenses: \(parent2LivingExpenses)
        Other Living Expenses: \(otherLivingExpenses)
        
        Spouse Age: \(spouseAge)
        Child 1 Age: \(child1Age)
        Child 2 Age: \(child2Age)
        Parent 1 Age: \(parent1Age)
        Parent 2 Age: \(parent2Age)
        Other Dependent Age: \(otherDependentAge)
        
        Spouse Employment Income: \(spouseEmploymentIncome)
        
        Cash Savings: \(cashSavings)
        Vested Retirement Accounts: \(vestedRetirementAccounts)
        Life Insurance: \(lifeInsurance)
        Property: \(property)
        
        Investment Portfolio - Equity: \(investmentPortfolioEquity)
        Investment Portfolio - Bonds: \(investmentPortfolioBonds)
        
        Life Insurance Required: \(currency) \(lifeInsuranceRequirement ?? 0.0)
        Net Worth: \(currency) \(netWorth ?? 0.0)
        """
        
        let filePath = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try fileContents.write(to: filePath, atomically: true, encoding: .utf8)
            
            let activityVC = UIActivityViewController(activityItems: [filePath], applicationActivities: nil)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true, completion: nil)
            }
        } catch {
            print("Error exporting data: \(error)")
        }
    }
}


// MARK: - Ads and App Functionality View

// View showing information about ads and the app functionality
struct ShowAdsAndAppFunctionalityView: View {
    var onConfirm: () -> Void

    var body: some View {
        ScrollView {
            VStack {
                // Section header
                HStack {
                    Text("Ads & App Functionality")
                        .font(.title3.bold())
                    Spacer()
                }
                Divider().background(Color.gray)

                // Ads section
                VStack {
                    // Ads header
                    HStack {
                        Text("Ads")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    // Ad image with link
                    ZStack {
                        Image("threedollar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(25)
                            .clipped()
                            .onTapGesture {
                                if let url = URL(string: "https://b33.biz/three-dollar/") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                    
                    // App Cards for ads
                    VStack {
                        Divider().background(Color.gray)

                        AppCardView(imageName: "sos", appName: "SOS Light", appDescription: "SOS Light is designed to maximize the chances of getting help in emergency situations.", appURL: "https://apps.apple.com/app/s0s-light/id6504213303")
                        
                        Divider().background(Color.gray)
                        AppCardView(imageName: "bodycam", appName: "BODYCam", appDescription: "Record videos effortlessly and discreetly.", appURL: "https://apps.apple.com/id/app/b0dycam/id6496689003")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "timetell", appName: "TimeTell", appDescription: "Announce the time every 30 seconds, no more guessing and checking your watch, for time-sensitive tasks.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "SingLoop", appName: "Sing LOOP", appDescription: "Record your voice effortlessly, and play it back in a loop.", appURL: "https://apps.apple.com/id/app/sing-l00p/id6480459464")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "loopspeak", appName: "LOOPSpeak", appDescription: "Type or paste your text, play in loop, and enjoy hands-free narration.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "insomnia", appName: "Insomnia Sheep", appDescription: "Design to ease your mind and help you relax leading up to sleep.", appURL: "https://apps.apple.com/id/app/insomnia-sheep/id6479727431")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "dryeye", appName: "Dry Eye Read", appDescription: "The go-to solution for a comfortable reading experience, by adjusting font size and color to suit your reading experience.", appURL: "https://apps.apple.com/id/app/dry-eye-read/id6474282023")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "iprogram", appName: "iProgramMe", appDescription: "Custom affirmations, schedule notifications, stay inspired daily.", appURL: "https://apps.apple.com/id/app/iprogramme/id6470770935")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "temptation", appName: "TemptationTrack", appDescription: "One button to track milestones, monitor progress, stay motivated.", appURL: "https://apps.apple.com/id/app/temptationtrack/id6471236988")
                        Divider().background(Color.gray)
                    }
                    Spacer()
                }
                .padding()
                .cornerRadius(15.0)

                // App functionality section
                HStack {
                    Text("App Functionality")
                        .font(.title.bold())
                    Spacer()
                }

                Text("""
                • Parameters Explanation:
                * Final Expenses: Estimated costs for funeral, medical bills, etc.
                * Taxes Payables: Estimated taxes due at the time of death.
                * Mortgage Retirement: Outstanding mortgage balance.
                * Other Debts: Any other debts that need to be paid off.
                * Education Fund: Funds set aside for children’s education.
                * Emergency Fund: Funds for unforeseen expenses.
                * Living Expenses: Annual living expenses for each dependent.
                * Retirement Age: Assumed age when the spouse stops working (default: 65 years old).
                * Age at End of Education for Children: Assumed age when children finish their education (default: 21 years old).
                * Other Living expenses annualy: another Children
                * Employment Income: Annual income from employment.
                * Cash and Savings: Liquid assets available.
                * Vested Retirement Accounts: Retirement accounts that can be accessed.
                * Life Insurance: Existing life insurance policies.
                * Property: Value of property owned.
                * Investment Portfolio - Equity: Investments in equities.
                * Investment Portfolio - Bonds: Investments in bonds.



                Example Calculation for an American User
                Input Data:
                * Name of Applicant: John Doe
                * Country of Applicant: USA
                * Currency used: USD
                Expenses:
                * Final Expenses: $10,000
                * Taxes Payables: $5,000
                * Mortgage Retirement: $200,000
                * Other Debts: $15,000
                * Education Fund: $50,000
                * Emergency Fund: $25,000
                * Others: $0
                Living expenses annually:
                * Spouse: $40,000
                * Child 1: $20,000
                * Child 2: $20,000
                * Parent 1: $0
                * Parent 2: $0
                * Other: $0
                Dependent Age:
                * Spouse: 40
                * Child 1: 8
                * Child 2: 5
                * Parent 1: N/A
                * Parent 2: N/A
                * Other: N/A
                Employment income:
                * Spouse: $50,000
                Portfolio:
                * Cash and Savings: $30,000
                * Vested retirement accounts: $100,000
                * Life Insurance: $50,000
                * Property: $200,000
                Other assets:
                * Investment Portfolio - Equity: $50,000
                * Investment Portfolio - Bonds: $20,000
                Assumptions:
                * Retirement Age: 65 years old
                * Age at End of Education for Children: 21 years old

                Calculation Steps:
                1. Cash Needs:
                    * Final Expenses: $10,000
                    * Taxes Payables: $5,000
                    * Mortgage Retirement: $200,000
                    * Other Debts: $15,000
                    * Education Fund: $50,000
                    * Emergency Fund: $25,000
                    * Total: $305,000
                2. Capital Needs:
                    * Spouse: $1,000,000
                    * Child 1: $260,000
                    * Child 2: $320,000
                    * Total: $1,580,000
                3. Total Financial Needs:
                    * Cash Needs: $305,000
                    * Capital Needs: $1,580,000
                    * Total: $1,885,000
                4. Total Capital Available:
                    * Cash and Savings: $30,000
                    * Vested Retirement Accounts: $100,000
                    * Life Insurance: $50,000
                    * Property: $200,000
                    * Investment Portfolio - Equity: $50,000
                    * Investment Portfolio - Bonds: $20,000
                    * Total: $450,000
                5. Life Insurance Requirement:
                    * Total Financial Needs: $1,885,000
                    * Total Capital Available: $450,000
                    * Life Insurance Requirement: $1,435,000
                
                6. Net Worth value :
                    * Net worth is a financial metric that represents the difference between what you own (assets) and what you owe (liabilities). The formula for net worth is:

                Net Worth = Total Assets − Total Liabilities

                Assets and Liabilities
                Assets: These are things you own that have value. Assets include:

                * Cash and savings
                * Vested retirement accounts
                * Property
                * Investment portfolio (both equity and bonds)
                
                Liabilities: These are things you owe or future obligations.  Liabilities include:

                * Final expenses
                * Taxes payable
                * Mortgage retirement
                * Other debt
                * Other expenses

                """)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .padding()

                Spacer()

                HStack {
                    Text("Whats's Your Worth? is developed by Three Dollar.")
                        .font(.title3.bold())
                    Spacer()
                }

                // Close button
                Button("Close") {
                    onConfirm()
                }
                .font(.title)
                .padding()
                .cornerRadius(25.0)
            }
            .padding()
            .cornerRadius(15.0)
        }
    }
}

// MARK: - Ads App Card View

// View displaying individual ads app cards
struct AppCardView: View {
    var imageName: String
    var appName: String
    var appDescription: String
    var appURL: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(7)

            VStack(alignment: .leading) {
                Text(appName)
                    .font(.title3)
                Text(appDescription)
                    .font(.caption)
            }
            .frame(alignment: .leading)

            Spacer()

            // Try button
            Button(action: {
                if let url = URL(string: appURL) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Try")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ContentView()
}

/*
//great, but want to do net worth improvement
import SwiftUI
import Foundation

struct ContentView: View {
    @State private var valuationDate = Date()
    @State private var name = ""
    @State private var country = ""
    @State private var currency = ""
    
    //Ads and app functionality
    @State private var showAdsAndAppFunctionality = false
    
    // Expenses
    @State private var finalExpenses = ""
    @State private var taxesPayable = ""
    @State private var mortgageRetirement = ""
    @State private var otherDebt = ""
    @State private var educationFund = ""
    @State private var emergencyFund = ""
    @State private var otherExpenses = ""
    
    // Living Expenses Annually
    @State private var spouseLivingExpenses = ""
    @State private var child1LivingExpenses = ""
    @State private var child2LivingExpenses = ""
    @State private var parent1LivingExpenses = ""
    @State private var parent2LivingExpenses = ""
    @State private var otherLivingExpenses = ""
    
    // Dependent Age
    @State private var spouseAge = ""
    @State private var child1Age = ""
    @State private var child2Age = ""
    @State private var parent1Age = ""
    @State private var parent2Age = ""
    @State private var otherDependentAge = ""
    
    // Employment Income
    @State private var spouseEmploymentIncome = ""
    
    // Portfolio
    @State private var cashSavings = ""
    @State private var vestedRetirementAccounts = ""
    @State private var lifeInsurance = ""
    @State private var property = ""
    
    // Other Assets
    @State private var investmentPortfolioEquity = ""
    @State private var investmentPortfolioBonds = ""
    
    // Calculation Results
    @State private var lifeInsuranceRequirement: Double?
    
    var body: some View {
        NavigationView {
            
       
            
            Form {
                Section(header: Text("Valuation Date")) {
                    DatePicker("Date", selection: $valuationDate, displayedComponents: .date)
                }
                
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Country", text: $country)
                    TextField("Currency", text: $currency)
                }
                
                Section(header: Text("Expenses")) {
                    TextField("Final Expenses", text: $finalExpenses).keyboardType(.decimalPad)
                    TextField("Taxes Payable", text: $taxesPayable).keyboardType(.decimalPad)
                    TextField("Mortgage Retirement", text: $mortgageRetirement).keyboardType(.decimalPad)
                    TextField("Other Debt", text: $otherDebt).keyboardType(.decimalPad)
                    TextField("Education Fund", text: $educationFund).keyboardType(.decimalPad)
                    TextField("Emergency Fund", text: $emergencyFund).keyboardType(.decimalPad)
                    TextField("Other Expenses", text: $otherExpenses).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Living Expenses Annually")) {
                    TextField("Spouse", text: $spouseLivingExpenses).keyboardType(.decimalPad)
                    TextField("Child 1", text: $child1LivingExpenses).keyboardType(.decimalPad)
                    TextField("Child 2", text: $child2LivingExpenses).keyboardType(.decimalPad)
                    TextField("Parent 1", text: $parent1LivingExpenses).keyboardType(.decimalPad)
                    TextField("Parent 2", text: $parent2LivingExpenses).keyboardType(.decimalPad)
                    TextField("Other", text: $otherLivingExpenses).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Dependent Age")) {
                    TextField("Spouse", text: $spouseAge).keyboardType(.decimalPad)
                    TextField("Child 1", text: $child1Age).keyboardType(.decimalPad)
                    TextField("Child 2", text: $child2Age).keyboardType(.decimalPad)
                    TextField("Parent 1", text: $parent1Age).keyboardType(.decimalPad)
                    TextField("Parent 2", text: $parent2Age).keyboardType(.decimalPad)
                    TextField("Other", text: $otherDependentAge).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Employment Income")) {
                    TextField("Spouse", text: $spouseEmploymentIncome).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Portfolio")) {
                    TextField("Cash and Savings", text: $cashSavings).keyboardType(.decimalPad)
                    TextField("Vested Retirement Accounts", text: $vestedRetirementAccounts).keyboardType(.decimalPad)
                    TextField("Life Insurance", text: $lifeInsurance).keyboardType(.decimalPad)
                    TextField("Property", text: $property).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Other Assets")) {
                    TextField("Investment Portfolio - Equity", text: $investmentPortfolioEquity).keyboardType(.decimalPad)
                    TextField("Investment Portfolio - Bonds", text: $investmentPortfolioBonds).keyboardType(.decimalPad)
                }
                
                Section {
                    Button(action: calculateLifeInsuranceRequirement) {
                        Text("Calculate Life Insurance Requirement")
                    }
                    
                    Button(action: exportData) {
                        Text("Export Data")
                    }
                }
                
                if let requirement = lifeInsuranceRequirement {
                    Section(header: Text("Valuation Output")) {
                        Text("Life Insurance Required: \(currency) \(requirement, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarItems(leading:
                HStack {
                    Text("What's Your Worth?")
                        .font(.title2)
                    Spacer()
                    Button(action: {
                        showAdsAndAppFunctionality = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(.white))
                            .padding()
                            .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 2)
                    }
                }
            )
            .font(.title3)
            
            /*
            .navigationBarItems(leading: Text("What's Your Worth?")
                .font(.title) )
            .font(.title2)
            */
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .sheet(isPresented: $showAdsAndAppFunctionality) {
            ShowAdsAndAppFunctionalityView(onConfirm: {
                showAdsAndAppFunctionality = false
            })
        }
    }
    
    
    func calculateLifeInsuranceRequirement() {
        // Parsing inputs to Double
        let finalExpensesValue = Double(finalExpenses) ?? 0.0
        let taxesPayableValue = Double(taxesPayable) ?? 0.0
        let mortgageRetirementValue = Double(mortgageRetirement) ?? 0.0
        let otherDebtValue = Double(otherDebt) ?? 0.0
        let educationFundValue = Double(educationFund) ?? 0.0
        let emergencyFundValue = Double(emergencyFund) ?? 0.0
        let otherExpensesValue = Double(otherExpenses) ?? 0.0
        
        let spouseLivingExpensesValue = Double(spouseLivingExpenses) ?? 0.0
        let child1LivingExpensesValue = Double(child1LivingExpenses) ?? 0.0
        let child2LivingExpensesValue = Double(child2LivingExpenses) ?? 0.0
        let parent1LivingExpensesValue = Double(parent1LivingExpenses) ?? 0.0
        let parent2LivingExpensesValue = Double(parent2LivingExpenses) ?? 0.0
        let otherLivingExpensesValue = Double(otherLivingExpenses) ?? 0.0
        
        let cashSavingsValue = Double(cashSavings) ?? 0.0
        let vestedRetirementAccountsValue = Double(vestedRetirementAccounts) ?? 0.0
        let lifeInsuranceValue = Double(lifeInsurance) ?? 0.0
        let propertyValue = Double(property) ?? 0.0
        
        let investmentPortfolioEquityValue = Double(investmentPortfolioEquity) ?? 0.0
        let investmentPortfolioBondsValue = Double(investmentPortfolioBonds) ?? 0.0
        
        // Calculate total expenses
        let totalExpenses = finalExpensesValue + taxesPayableValue + mortgageRetirementValue + otherDebtValue + educationFundValue + emergencyFundValue + otherExpensesValue
        
        // Calculate living expenses over the years
        let yearsToRetirement = 65 - (Double(spouseAge) ?? 0.0)
        let spouseLivingExpensesTotal = spouseLivingExpensesValue * yearsToRetirement
        
        let child1LivingExpensesTotal = child1LivingExpensesValue * max(21 - (Double(child1Age) ?? 0.0), 0)
        let child2LivingExpensesTotal = child2LivingExpensesValue * max(21 - (Double(child2Age) ?? 0.0), 0)
        
        let parent1LivingExpensesTotal = parent1LivingExpensesValue * max(85 - (Double(parent1Age) ?? 0.0), 0)
        let parent2LivingExpensesTotal = parent2LivingExpensesValue * max(85 - (Double(parent2Age) ?? 0.0), 0)
        
        let otherLivingExpensesTotal = otherLivingExpensesValue * max(85 - (Double(otherDependentAge) ?? 0.0), 0)
        
        let totalLivingExpenses = spouseLivingExpensesTotal + child1LivingExpensesTotal + child2LivingExpensesTotal + parent1LivingExpensesTotal + parent2LivingExpensesTotal + otherLivingExpensesTotal
        
        // Calculate total capital available
        let totalCapitalAvailable = cashSavingsValue + vestedRetirementAccountsValue + lifeInsuranceValue + propertyValue + investmentPortfolioEquityValue + investmentPortfolioBondsValue
        
        // Calculate life insurance requirement
        lifeInsuranceRequirement = (totalExpenses + totalLivingExpenses) - totalCapitalAvailable
    }
    
    func exportData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formattedDate = dateFormatter.string(from: valuationDate)
        
        let data = """
        Valuation Date: \(formattedDate)
        Name of Applicant: \(name)
        Country of Applicant: \(country)
        Currency used: \(currency)
        
        Expenses:
        Final Expenses: \(finalExpenses)
        Taxes Payables: \(taxesPayable)
        Mortgage Retirement: \(mortgageRetirement)
        Other Debts: \(otherDebt)
        Education Fund: \(educationFund)
        Emergency Fund: \(emergencyFund)
        Others: \(otherExpenses)
        
        Living expenses annually:
        Spouse: \(spouseLivingExpenses)
        Child 1: \(child1LivingExpenses)
        Child 2: \(child2LivingExpenses)
        Parent 1: \(parent1LivingExpenses)
        Parent 2: \(parent2LivingExpenses)
        Other: \(otherLivingExpenses)
        
        Dependent Age:
        Spouse: \(spouseAge)
        Child 1: \(child1Age)
        Child 2: \(child2Age)
        Parent 1: \(parent1Age)
        Parent 2: \(parent2Age)
        Other: \(otherDependentAge)
        
        Employment income:
        Spouse: \(spouseEmploymentIncome)
        
        Portfolio:
        Cash and Savings: \(cashSavings)
        Vested retirement accounts: \(vestedRetirementAccounts)
        Life Insurance: \(lifeInsurance)
        Property: \(property)
        
        Other assets:
        Investment Portfolio - Equity: \(investmentPortfolioEquity)
        Investment Portfolio - Bonds: \(investmentPortfolioBonds)
        
        Valuation Output - Life Insurance Required: \(lifeInsuranceRequirement ?? 0.0)
        """
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("LifeInsuranceData.txt")
        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
            print("Data exported successfully to \(url)")
        } catch {
            print("Failed to export data: \(error.localizedDescription)")
        }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(activityVC, animated: true, completion: nil)
        }
    }
}

struct WhatsYourWorthApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// MARK: - Ads and App Functionality View

// View showing information about ads and the app functionality
struct ShowAdsAndAppFunctionalityView: View {
    var onConfirm: () -> Void

    var body: some View {
        ScrollView {
            VStack {
                // Section header
                HStack {
                    Text("Ads & App Functionality")
                        .font(.title3.bold())
                    Spacer()
                }
                Divider().background(Color.gray)

                // Ads section
                VStack {
                    // Ads header
                    HStack {
                        Text("Ads")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    // Ad image with link
                    ZStack {
                        Image("threedollar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(25)
                            .clipped()
                            .onTapGesture {
                                if let url = URL(string: "https://b33.biz/three-dollar/") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                    
                    // App Cards for ads
                    VStack {
                        Divider().background(Color.gray)
                        AppCardView(imageName: "bodycam", appName: "BODYCam", appDescription: "Record videos effortlessly and discreetly.", appURL: "https://apps.apple.com/id/app/b0dycam/id6496689003")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "timetell", appName: "TimeTell", appDescription: "Announce the time every 30 seconds, no more guessing and checking your watch, for time-sensitive tasks.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "SingLoop", appName: "Sing LOOP", appDescription: "Record your voice effortlessly, and play it back in a loop.", appURL: "https://apps.apple.com/id/app/sing-l00p/id6480459464")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "loopspeak", appName: "LOOPSpeak", appDescription: "Type or paste your text, play in loop, and enjoy hands-free narration.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "insomnia", appName: "Insomnia Sheep", appDescription: "Design to ease your mind and help you relax leading up to sleep.", appURL: "https://apps.apple.com/id/app/insomnia-sheep/id6479727431")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "dryeye", appName: "Dry Eye Read", appDescription: "The go-to solution for a comfortable reading experience, by adjusting font size and color to suit your reading experience.", appURL: "https://apps.apple.com/id/app/dry-eye-read/id6474282023")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "iprogram", appName: "iProgramMe", appDescription: "Custom affirmations, schedule notifications, stay inspired daily.", appURL: "https://apps.apple.com/id/app/iprogramme/id6470770935")
                        Divider().background(Color.gray)

                        AppCardView(imageName: "temptation", appName: "TemptationTrack", appDescription: "One button to track milestones, monitor progress, stay motivated.", appURL: "https://apps.apple.com/id/app/temptationtrack/id6471236988")
                        Divider().background(Color.gray)
                    }
                    Spacer()
                }
                .padding()
                .cornerRadius(15.0)

                // App functionality section
                HStack {
                    Text("App Functionality")
                        .font(.title.bold())
                    Spacer()
                }

                Text("""
                • Parameters Explanation:
                * Final Expenses: Estimated costs for funeral, medical bills, etc.
                * Taxes Payables: Estimated taxes due at the time of death.
                * Mortgage Retirement: Outstanding mortgage balance.
                * Other Debts: Any other debts that need to be paid off.
                * Education Fund: Funds set aside for children’s education.
                * Emergency Fund: Funds for unforeseen expenses.
                * Living Expenses: Annual living expenses for each dependent.
                * Retirement Age: Assumed age when the spouse stops working (default: 65 years old).
                * Age at End of Education for Children: Assumed age when children finish their education (default: 21 years old).
                * Employment Income: Annual income from employment.
                * Cash and Savings: Liquid assets available.
                * Vested Retirement Accounts: Retirement accounts that can be accessed.
                * Life Insurance: Existing life insurance policies.
                * Property: Value of property owned.
                * Investment Portfolio - Equity: Investments in equities.
                * Investment Portfolio - Bonds: Investments in bonds.



                Example Calculation for an American User
                Input Data:
                * Name of Applicant: John Doe
                * Country of Applicant: USA
                * Currency used: USD
                Expenses:
                * Final Expenses: $10,000
                * Taxes Payables: $5,000
                * Mortgage Retirement: $200,000
                * Other Debts: $15,000
                * Education Fund: $50,000
                * Emergency Fund: $25,000
                * Others: $0
                Living expenses annually:
                * Spouse: $40,000
                * Child 1: $20,000
                * Child 2: $20,000
                * Parent 1: $0
                * Parent 2: $0
                * Other: $0
                Dependent Age:
                * Spouse: 40
                * Child 1: 8
                * Child 2: 5
                * Parent 1: N/A
                * Parent 2: N/A
                * Other: N/A
                Employment income:
                * Spouse: $50,000
                Portfolio:
                * Cash and Savings: $30,000
                * Vested retirement accounts: $100,000
                * Life Insurance: $50,000
                * Property: $200,000
                Other assets:
                * Investment Portfolio - Equity: $50,000
                * Investment Portfolio - Bonds: $20,000
                Assumptions:
                * Retirement Age: 65 years old
                * Age at End of Education for Children: 21 years old

                Calculation Steps:
                1. Cash Needs:
                    * Final Expenses: $10,000
                    * Taxes Payables: $5,000
                    * Mortgage Retirement: $200,000
                    * Other Debts: $15,000
                    * Education Fund: $50,000
                    * Emergency Fund: $25,000
                    * Total: $305,000
                2. Capital Needs:
                    * Spouse: $1,000,000
                    * Child 1: $260,000
                    * Child 2: $320,000
                    * Total: $1,580,000
                3. Total Financial Needs:
                    * Cash Needs: $305,000
                    * Capital Needs: $1,580,000
                    * Total: $1,885,000
                4. Total Capital Available:
                    * Cash and Savings: $30,000
                    * Vested Retirement Accounts: $100,000
                    * Life Insurance: $50,000
                    * Property: $200,000
                    * Investment Portfolio - Equity: $50,000
                    * Investment Portfolio - Bonds: $20,000
                    * Total: $450,000
                5. Life Insurance Requirement:
                    * Total Financial Needs: $1,885,000
                    * Total Capital Available: $450,000
                    * Life Insurance Requirement: $1,435,000

                """)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .padding()

                Spacer()

                HStack {
                    Text("Whats's Your Worth? is developed by Three Dollar.")
                        .font(.title3.bold())
                    Spacer()
                }

                // Close button
                Button("Close") {
                    onConfirm()
                }
                .font(.title)
                .padding()
                .cornerRadius(25.0)
            }
            .padding()
            .cornerRadius(15.0)
        }
    }
}

// MARK: - Ads App Card View

// View displaying individual ads app cards
struct AppCardView: View {
    var imageName: String
    var appName: String
    var appDescription: String
    var appURL: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(7)

            VStack(alignment: .leading) {
                Text(appName)
                    .font(.title3)
                Text(appDescription)
                    .font(.caption)
            }
            .frame(alignment: .leading)

            Spacer()

            // Try button
            Button(action: {
                if let url = URL(string: appURL) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Try")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ContentView()
}

*/
/*
//need major changes
import SwiftUI
import UIKit

struct ContentView: View {
    @State private var valuationDate = Date()
    @State private var applicantName = ""
    @State private var applicantCountry = ""
    @State private var currencyUsed = ""
    
    @State private var finalExpenses = ""
    @State private var taxesPayable = ""
    @State private var mortgagePayment = ""
    @State private var otherDebts = ""
    @State private var educationFunds = ""
    @State private var emergencyFunds = ""
    @State private var otherExpenses = ""
    
    @State private var spouseLivingExpense = ""
    @State private var child1LivingExpense = ""
    @State private var child2LivingExpense = ""
    @State private var parent1LivingExpense = ""
    @State private var parent2LivingExpense = ""
    @State private var otherLivingExpense = ""
    
    @State private var spouseAge = ""
    @State private var child1Age = ""
    @State private var child2Age = ""
    @State private var parent1Age = ""
    @State private var parent2Age = ""
    @State private var otherAge = ""
    
    @State private var spouseEmploymentIncome = ""
    
    @State private var cashAndSavings = ""
    @State private var vestedRetirementAccount = ""
    @State private var lifeInsurance = ""
    @State private var property = ""
    @State private var otherAssets = ""
    @State private var investmentBonds = ""
    @State private var investmentEquity = ""
    
    @State private var insuranceRequirement: Double = 0.0
    @State private var showDocumentPicker = false
    @State private var exportFileURL: URL?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Applicant Information")) {
                    DatePicker("Valuation Date", selection: $valuationDate, displayedComponents: .date)
                    TextField("Name of Applicant", text: $applicantName)
                    TextField("Country of Applicant", text: $applicantCountry)
                    TextField("Currency Used", text: $currencyUsed)
                }
                
                Section(header: Text("Expenses")) {
                    TextField("Final Expenses", text: $finalExpenses)
                    TextField("Taxes Payable", text: $taxesPayable)
                    TextField("Mortgage Payment", text: $mortgagePayment)
                    TextField("Other Debts", text: $otherDebts)
                    TextField("Education Funds", text: $educationFunds)
                    TextField("Emergency Funds", text: $emergencyFunds)
                    TextField("Other Expenses", text: $otherExpenses)
                }
                
                Section(header: Text("Living Expenses")) {
                    TextField("Spouse Living Expense", text: $spouseLivingExpense)
                    TextField("Child 1 Living Expense", text: $child1LivingExpense)
                    TextField("Child 2 Living Expense", text: $child2LivingExpense)
                    TextField("Parent 1 Living Expense", text: $parent1LivingExpense)
                    TextField("Parent 2 Living Expense", text: $parent2LivingExpense)
                    TextField("Other Living Expense", text: $otherLivingExpense)
                }
                
                Section(header: Text("Ages")) {
                    TextField("Spouse Age", text: $spouseAge)
                    TextField("Child 1 Age", text: $child1Age)
                    TextField("Child 2 Age", text: $child2Age)
                    TextField("Parent 1 Age", text: $parent1Age)
                    TextField("Parent 2 Age", text: $parent2Age)
                    TextField("Other Age", text: $otherAge)
                }
                
                Section(header: Text("Employment Income")) {
                    TextField("Spouse Employment Income", text: $spouseEmploymentIncome)
                }
                
                Section(header: Text("Portfolio")) {
                    TextField("Cash and Savings", text: $cashAndSavings)
                    TextField("Vested Retirement Account", text: $vestedRetirementAccount)
                    TextField("Life Insurance", text: $lifeInsurance)
                    TextField("Property", text: $property)
                    TextField("Other Assets", text: $otherAssets)
                    TextField("Investment Bonds", text: $investmentBonds)
                    TextField("Investment Equity", text: $investmentEquity)
                }
                
                Section(header: Text("Calculated Insurance Requirement")) {
                    Text("\(insuranceRequirement, specifier: "%.2f")")
                    Button(action: calculateInsuranceRequirement) {
                        Text("Calculate")
                    }
                }
                
                Button(action: exportData) {
                    Text("Export Data")
                }
            }
            .navigationBarTitle("What's Your Worth?")
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker(fileURL: $exportFileURL)
        }
    }
    
    func calculateInsuranceRequirement() {
        // Convert input strings to Double
        let finalExpensesValue = Double(finalExpenses) ?? 0.0
        let taxesPayableValue = Double(taxesPayable) ?? 0.0
        let mortgagePaymentValue = Double(mortgagePayment) ?? 0.0
        let otherDebtsValue = Double(otherDebts) ?? 0.0
        let educationFundsValue = Double(educationFunds) ?? 0.0
        let emergencyFundsValue = Double(emergencyFunds) ?? 0.0
        let otherExpensesValue = Double(otherExpenses) ?? 0.0
        
        let spouseLivingExpenseValue = Double(spouseLivingExpense) ?? 0.0
        let child1LivingExpenseValue = Double(child1LivingExpense) ?? 0.0
        let child2LivingExpenseValue = Double(child2LivingExpense) ?? 0.0
        let parent1LivingExpenseValue = Double(parent1LivingExpense) ?? 0.0
        let parent2LivingExpenseValue = Double(parent2LivingExpense) ?? 0.0
        let otherLivingExpenseValue = Double(otherLivingExpense) ?? 0.0
        
        let spouseAgeValue = Double(spouseAge) ?? 0.0
        let child1AgeValue = Double(child1Age) ?? 0.0
        let child2AgeValue = Double(child2Age) ?? 0.0
        let parent1AgeValue = Double(parent1Age) ?? 0.0
        let parent2AgeValue = Double(parent2Age) ?? 0.0
        let otherAgeValue = Double(otherAge) ?? 0.0
        
        let spouseEmploymentIncomeValue = Double(spouseEmploymentIncome) ?? 0.0
        
        let cashAndSavingsValue = Double(cashAndSavings) ?? 0.0
        let vestedRetirementAccountValue = Double(vestedRetirementAccount) ?? 0.0
        let lifeInsuranceValue = Double(lifeInsurance) ?? 0.0
        let propertyValue = Double(property) ?? 0.0
        let otherAssetsValue = Double(otherAssets) ?? 0.0
        let investmentBondsValue = Double(investmentBonds) ?? 0.0
        let investmentEquityValue = Double(investmentEquity) ?? 0.0

        // Calculate total expenses and income
        let totalExpenses = finalExpensesValue + taxesPayableValue + mortgagePaymentValue + otherDebtsValue + educationFundsValue + emergencyFundsValue + otherExpensesValue + spouseLivingExpenseValue + child1LivingExpenseValue + child2LivingExpenseValue + parent1LivingExpenseValue + parent2LivingExpenseValue + otherLivingExpenseValue
        let totalAssets = cashAndSavingsValue + vestedRetirementAccountValue + lifeInsuranceValue + propertyValue + otherAssetsValue + investmentBondsValue + investmentEquityValue
        
        // Calculate number of years support is needed
        let yearsSupportSpouse = max(0, 65 - spouseAgeValue)
        let yearsSupportChild1 = max(0, 18 - child1AgeValue)
        let yearsSupportChild2 = max(0, 18 - child2AgeValue)
        let yearsSupportParent1 = max(0, 65 - parent1AgeValue)
        let yearsSupportParent2 = max(0, 65 - parent2AgeValue)
        let yearsSupportOther = max(0, 65 - otherAgeValue)
        
        // Calculate living expense totals
        let totalLivingExpenses = (yearsSupportSpouse * spouseLivingExpenseValue) + (yearsSupportChild1 * child1LivingExpenseValue) + (yearsSupportChild2 * child2LivingExpenseValue) + (yearsSupportParent1 * parent1LivingExpenseValue) + (yearsSupportParent2 * parent2LivingExpenseValue) + (yearsSupportOther * otherLivingExpenseValue)
        
        // Calculate total income
        let totalIncome = yearsSupportSpouse * spouseEmploymentIncomeValue
        
        // Calculate insurance requirement
        insuranceRequirement = totalExpenses + totalLivingExpenses - totalAssets - totalIncome
    }
    
    func exportData() {
        let content = """
        Valuation Date: \(formattedDate(valuationDate))
        Applicant Name: \(applicantName)
        Applicant Country: \(applicantCountry)
        Currency Used: \(currencyUsed)
        
        Final Expenses: \(finalExpenses)
        Taxes Payable: \(taxesPayable)
        Mortgage Payment: \(mortgagePayment)
        Other Debts: \(otherDebts)
        Education Funds: \(educationFunds)
        Emergency Funds: \(emergencyFunds)
        Other Expenses: \(otherExpenses)
        
        Spouse Living Expense: \(spouseLivingExpense)
        Child 1 Living Expense: \(child1LivingExpense)
        Child 2 Living Expense: \(child2LivingExpense)
        Parent 1 Living Expense: \(parent1LivingExpense)
        Parent 2 Living Expense: \(parent2LivingExpense)
        Other Living Expense: \(otherLivingExpense)
        
        Spouse Age: \(spouseAge)
        Child 1 Age: \(child1Age)
        Child 2 Age: \(child2Age)
        Parent 1 Age: \(parent1Age)
        Parent 2 Age: \(parent2Age)
        Other Age: \(otherAge)
        
        Spouse Employment Income: \(spouseEmploymentIncome)
        
        Cash and Savings: \(cashAndSavings)
        Vested Retirement Account: \(vestedRetirementAccount)
        Life Insurance: \(lifeInsurance)
        Property: \(property)
        Other Assets: \(otherAssets)
        Investment Bonds: \(investmentBonds)
        Investment Equity: \(investmentEquity)
        
        Insurance Requirement: \(insuranceRequirement)
        """
        
        let fileName = "WhatsYourWorthData.txt"
        if let fileURL = writeToFile(content: content, fileName: fileName) {
            exportFileURL = fileURL
            showDocumentPicker = true
        }
    }
    
    func writeToFile(content: String, fileName: String) -> URL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = urls.first else {
            return nil
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Error writing to file: \(error)")
            return nil
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var fileURL: URL?
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forExporting: [fileURL!])
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}

#Preview {
    ContentView()
}

*/
/*
//perubahan total
import SwiftUI
import Foundation

struct ContentView: View {
    @State private var name = ""
    @State private var age = ""
    @State private var country = ""
    @State private var currency = ""
    
    // Financial Needs
    @State private var finalExpenses = ""
    @State private var taxesPayable = ""
    @State private var mortgageRetirement = ""
    @State private var otherDebt = ""
    @State private var educationFund = ""
    @State private var emergencyFund = ""
    
    // Living Expenses
    @State private var livingExpensesOwned = ""
    @State private var spouseLivingExpenses = ""
    @State private var child1LivingExpenses = ""
    @State private var child2LivingExpenses = ""
    @State private var parent1LivingExpenses = ""
    @State private var parent2LivingExpenses = ""
    
    // Ages
    @State private var spouseAge = ""
    @State private var child1Age = ""
    @State private var child2Age = ""
    @State private var parent1Age = ""
    @State private var parent2Age = ""
    
    // Employment Income
    @State private var employmentIncomeOwned = ""
    @State private var spouseEmploymentIncome = ""
    
    // Capital Available
    @State private var cashSavings = ""
    @State private var vestedRetirementAccounts = ""
    @State private var investmentPortfolioEquity = ""
    @State private var investmentPortfolioBonds = ""
    
    // Calculation Results
    @State private var lifeInsuranceRequirement: Double?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Country", text: $country)
                    TextField("Currency", text: $currency)
                }
                
                Section(header: Text("Financial Needs")) {
                    TextField("Final Expenses", text: $finalExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Taxes Payable", text: $taxesPayable)
                        .keyboardType(.decimalPad)
                    TextField("Mortgage Retirement", text: $mortgageRetirement)
                        .keyboardType(.decimalPad)
                    TextField("Other Debt", text: $otherDebt)
                        .keyboardType(.decimalPad)
                    TextField("Education Fund", text: $educationFund)
                        .keyboardType(.decimalPad)
                    TextField("Emergency Fund", text: $emergencyFund)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Living Expenses (Annual)")) {
                    TextField("Your Living Expenses", text: $livingExpensesOwned)
                        .keyboardType(.decimalPad)
                    TextField("Spouse Living Expenses", text: $spouseLivingExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Child 1 Living Expenses", text: $child1LivingExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Child 2 Living Expenses", text: $child2LivingExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Parent 1 Living Expenses", text: $parent1LivingExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Parent 2 Living Expenses", text: $parent2LivingExpenses)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Ages")) {
                    TextField("Spouse Age", text: $spouseAge)
                        .keyboardType(.numberPad)
                    TextField("Child 1 Age", text: $child1Age)
                        .keyboardType(.numberPad)
                    TextField("Child 2 Age", text: $child2Age)
                        .keyboardType(.numberPad)
                    TextField("Parent 1 Age", text: $parent1Age)
                        .keyboardType(.numberPad)
                    TextField("Parent 2 Age", text: $parent2Age)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Employment Income (Annual)")) {
                    TextField("Your Employment Income", text: $employmentIncomeOwned)
                        .keyboardType(.decimalPad)
                    TextField("Spouse Employment Income", text: $spouseEmploymentIncome)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Capital Available")) {
                    TextField("Cash Savings", text: $cashSavings)
                        .keyboardType(.decimalPad)
                    TextField("Vested Retirement Accounts", text: $vestedRetirementAccounts)
                        .keyboardType(.decimalPad)
                    TextField("Investment Portfolio - Equity", text: $investmentPortfolioEquity)
                        .keyboardType(.decimalPad)
                    TextField("Investment Portfolio - Bonds", text: $investmentPortfolioBonds)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button(action: calculateLifeInsuranceRequirement) {
                        Text("Calculate Life Insurance Requirement")
                    }
                    
                    Button(action: exportData) {
                        Text("Export Data")
                    }
                }
                
                if let requirement = lifeInsuranceRequirement {
                    Section(header: Text("Life Insurance Requirement")) {
                        Text("\(currency) \(requirement, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("What's Your Worth?")
        }
    }
    
    // Function to calculate life insurance requirement
    func calculateLifeInsuranceRequirement() {
        let finalExpensesValue = Double(finalExpenses) ?? 0.0
        let taxesPayableValue = Double(taxesPayable) ?? 0.0
        let mortgageRetirementValue = Double(mortgageRetirement) ?? 0.0
        let otherDebtValue = Double(otherDebt) ?? 0.0
        let educationFundValue = Double(educationFund) ?? 0.0
        let emergencyFundValue = Double(emergencyFund) ?? 0.0
        let cashNeeds = finalExpensesValue + taxesPayableValue + mortgageRetirementValue + otherDebtValue + educationFundValue + emergencyFundValue
        
        let livingExpensesOwnedValue = Double(livingExpensesOwned) ?? 0.0
        let spouseLivingExpensesValue = Double(spouseLivingExpenses) ?? 0.0
        let child1LivingExpensesValue = Double(child1LivingExpenses) ?? 0.0
        let child2LivingExpensesValue = Double(child2LivingExpenses) ?? 0.0
        let parent1LivingExpensesValue = Double(parent1LivingExpenses) ?? 0.0
        let parent2LivingExpensesValue = Double(parent2LivingExpenses) ?? 0.0
        
        let ageValue = Double(age) ?? 0.0
        let spouseAgeValue = Double(spouseAge) ?? 0.0
        let child1AgeValue = Double(child1Age) ?? 0.0
        let child2AgeValue = Double(child2Age) ?? 0.0
        let parent1AgeValue = Double(parent1Age) ?? 0.0
        let parent2AgeValue = Double(parent2Age) ?? 0.0
        
        // Constants for life expectancies
        let retirementAge = 65.0
        let lifeExpectancy = 80.0
        
        // Calculate years of coverage needed
        let yearsUntilRetirement = max(retirementAge - ageValue, 0)
        let spouseYearsUntilLifeExpectancy = max(lifeExpectancy - spouseAgeValue, 0)
        let child1YearsUntilIndependent = max(18 - child1AgeValue, 0)
        let child2YearsUntilIndependent = max(18 - child2AgeValue, 0)
        let parent1YearsUntilLifeExpectancy = max(lifeExpectancy - parent1AgeValue, 0)
        let parent2YearsUntilLifeExpectancy = max(lifeExpectancy - parent2AgeValue, 0)
        
        let capitalNeeds = (livingExpensesOwnedValue * yearsUntilRetirement) +
        (spouseLivingExpensesValue * spouseYearsUntilLifeExpectancy) +
        (child1LivingExpensesValue * child1YearsUntilIndependent) +
        (child2LivingExpensesValue * child2YearsUntilIndependent) +
        (parent1LivingExpensesValue * parent1YearsUntilLifeExpectancy) +
        (parent2LivingExpensesValue * parent2YearsUntilLifeExpectancy)
        
        let totalFinancialNeeds = cashNeeds + capitalNeeds
        
        let cashSavingsValue = Double(cashSavings) ?? 0.0
        let vestedRetirementAccountsValue = Double(vestedRetirementAccounts) ?? 0.0
        let investmentPortfolioEquityValue = Double(investmentPortfolioEquity) ?? 0.0
        let investmentPortfolioBondsValue = Double(investmentPortfolioBonds) ?? 0.0
        let totalCapitalAvailable = cashSavingsValue + vestedRetirementAccountsValue + investmentPortfolioEquityValue + investmentPortfolioBondsValue
        
        let employmentIncomeOwnedValue = Double(employmentIncomeOwned) ?? 0.0
        let spouseEmploymentIncomeValue = Double(spouseEmploymentIncome) ?? 0.0
        let totalIncomeAvailable = employmentIncomeOwnedValue + spouseEmploymentIncomeValue
        
        // Life insurance requirement calculation
        lifeInsuranceRequirement = max(totalFinancialNeeds - totalCapitalAvailable - totalIncomeAvailable, 0.0)
    }
    
    // Function to export data
    func exportData() {
        let data = """
        Personal Information:
        Name: \(name)
        Age: \(age)
        Country: \(country)
        Currency: \(currency)
        
        Financial Needs:
        Final Expenses: \(finalExpenses)
        Taxes Payable: \(taxesPayable)
        Mortgage Retirement: \(mortgageRetirement)
        Other Debt: \(otherDebt)
        Education Fund: \(educationFund)
        Emergency Fund: \(emergencyFund)
        
        Living Expenses (Annual):
        Your Living Expenses: \(livingExpensesOwned)
        Spouse Living Expenses: \(spouseLivingExpenses)
        Child 1: \(child1LivingExpenses)
        Child 2: \(child2LivingExpenses)
        Parent 1: \(parent1LivingExpenses)
        Parent 2: \(parent2LivingExpenses)
        
        Ages:
        Spouse Age: \(spouseAge)
        Child 1 Age: \(child1Age)
        Child 2 Age: \(child2Age)
        Parent 1 Age: \(parent1Age)
        Parent 2 Age: \(parent2Age)
        
        Employment Income (Annual):
        Your Employment Income: \(employmentIncomeOwned)
        Spouse Employment Income: \(spouseEmploymentIncome)
        
        Capital Available:
        Cash Savings: \(cashSavings)
        Vested Retirement Accounts: \(vestedRetirementAccounts)
        Investment Portfolio - Equity: \(investmentPortfolioEquity)
        Investment Portfolio - Bonds: \(investmentPortfolioBonds)
        
        Life Insurance Requirement: \(lifeInsuranceRequirement ?? 0.0)
        """
        
        let filename = "LifeInsuranceData.txt"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
            print("Data exported successfully to \(url)")
            
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            if let topController = UIApplication.shared.windows.first?.rootViewController {
                topController.present(activityVC, animated: true, completion: nil)
            }
        } catch {
            print("Failed to export data: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/


/*
//udah ok tapi mau ada improvement
import SwiftUI
import Foundation

struct ContentView: View {
    @State private var name = ""
    @State private var age = ""
    @State private var country = ""
    @State private var currency = ""
    
    // Financial Needs
    @State private var finalExpenses = ""
    @State private var taxesPayable = ""
    @State private var mortgageRetirement = ""
    @State private var otherDebt = ""
    @State private var educationFund = ""
    @State private var emergencyFund = ""
    
    // Living Expenses
    @State private var livingExpensesOwned = ""
    @State private var spouseLivingExpenses = ""
    @State private var child1LivingExpenses = ""
    @State private var child2LivingExpenses = ""
    @State private var parentsLivingExpenses = ""
    
    // Employment Income
    @State private var employmentIncomeOwned = ""
    @State private var spouseEmploymentIncome = ""
    
    // Capital Available
    @State private var cashSavings = ""
    @State private var vestedRetirementAccounts = ""
    @State private var investmentPortfolioEquity = ""
    @State private var investmentPortfolioBonds = ""
    
    // Calculation Results
    @State private var lifeInsuranceRequirement: Double?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Country", text: $country)
                    TextField("Currency", text: $currency)
                }
                
                Section(header: Text("Financial Needs")) {
                    TextField("Final Expenses", text: $finalExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Taxes Payable", text: $taxesPayable)
                        .keyboardType(.decimalPad)
                    TextField("Mortgage Retirement", text: $mortgageRetirement)
                        .keyboardType(.decimalPad)
                    TextField("Other Debt", text: $otherDebt)
                        .keyboardType(.decimalPad)
                    TextField("Education Fund", text: $educationFund)
                        .keyboardType(.decimalPad)
                    TextField("Emergency Fund", text: $emergencyFund)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Living Expenses")) {
                    TextField("Your Living Expenses", text: $livingExpensesOwned)
                        .keyboardType(.decimalPad)
                    TextField("Spouse Living Expenses", text: $spouseLivingExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Child 1 Living Expenses", text: $child1LivingExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Child 2 Living Expenses", text: $child2LivingExpenses)
                        .keyboardType(.decimalPad)
                    TextField("Parents Living Expenses", text: $parentsLivingExpenses)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Employment Income")) {
                    TextField("Your Employment Income", text: $employmentIncomeOwned)
                        .keyboardType(.decimalPad)
                    TextField("Spouse Employment Income", text: $spouseEmploymentIncome)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Capital Available")) {
                    TextField("Cash Savings", text: $cashSavings)
                        .keyboardType(.decimalPad)
                    TextField("Vested Retirement Accounts", text: $vestedRetirementAccounts)
                        .keyboardType(.decimalPad)
                    TextField("Investment Portfolio - Equity", text: $investmentPortfolioEquity)
                        .keyboardType(.decimalPad)
                    TextField("Investment Portfolio - Bonds", text: $investmentPortfolioBonds)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button(action: calculateLifeInsuranceRequirement) {
                        Text("Calculate Life Insurance Requirement")
                    }
                    
                    Button(action: exportData) {
                        Text("Export Data")
                    }
                }
                
                if let requirement = lifeInsuranceRequirement {
                    Section(header: Text("Life Insurance Requirement")) {
                        Text("\(currency) \(requirement, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("What's Your Worth?")
        }
    }
    
    // Function to calculate life insurance requirement
    func calculateLifeInsuranceRequirement() {
        let finalExpensesValue = Double(finalExpenses) ?? 0.0
        let taxesPayableValue = Double(taxesPayable) ?? 0.0
        let mortgageRetirementValue = Double(mortgageRetirement) ?? 0.0
        let otherDebtValue = Double(otherDebt) ?? 0.0
        let educationFundValue = Double(educationFund) ?? 0.0
        let emergencyFundValue = Double(emergencyFund) ?? 0.0
        let cashNeeds = finalExpensesValue + taxesPayableValue + mortgageRetirementValue + otherDebtValue + educationFundValue + emergencyFundValue
        
        let livingExpensesOwnedValue = Double(livingExpensesOwned) ?? 0.0
        let spouseLivingExpensesValue = Double(spouseLivingExpenses) ?? 0.0
        let child1LivingExpensesValue = Double(child1LivingExpenses) ?? 0.0
        let child2LivingExpensesValue = Double(child2LivingExpenses) ?? 0.0
        let parentsLivingExpensesValue = Double(parentsLivingExpenses) ?? 0.0
        let capitalNeeds = (livingExpensesOwnedValue * 30) + (spouseLivingExpensesValue * 60) + (child1LivingExpensesValue * 5) + (child2LivingExpensesValue * 5) + (parentsLivingExpensesValue * 20)
        
        let totalFinancialNeeds = cashNeeds + capitalNeeds
        
        let cashSavingsValue = Double(cashSavings) ?? 0.0
        let vestedRetirementAccountsValue = Double(vestedRetirementAccounts) ?? 0.0
        let investmentPortfolioEquityValue = Double(investmentPortfolioEquity) ?? 0.0
        let investmentPortfolioBondsValue = Double(investmentPortfolioBonds) ?? 0.0
        let totalCapitalAvailable = cashSavingsValue + vestedRetirementAccountsValue + investmentPortfolioEquityValue + investmentPortfolioBondsValue
        
        lifeInsuranceRequirement = totalFinancialNeeds - totalCapitalAvailable
    }
    
    // Function to export data
    func exportData() {
        let data = """
        Name: \(name)
        Age: \(age)
        Country: \(country)
        Currency: \(currency)
        
        Financial Needs:
        Final Expenses: \(finalExpenses)
        Taxes Payable: \(taxesPayable)
        Mortgage Retirement: \(mortgageRetirement)
        Other Debt: \(otherDebt)
        Education Fund: \(educationFund)
        Emergency Fund: \(emergencyFund)
        
        Living Expenses:
        Your Living Expenses: \(livingExpensesOwned)
        Spouse: \(spouseLivingExpenses)
        Child 1: \(child1LivingExpenses)
        Child 2: \(child2LivingExpenses)
        Parents: \(parentsLivingExpenses)
        
        Employment Income:
        Your Income: \(employmentIncomeOwned)
        Spouse's Income: \(spouseEmploymentIncome)
        
        Capital Available:
        Cash Savings: \(cashSavings)
        Vested Retirement Accounts: \(vestedRetirementAccounts)
        Investment Portfolio - Equity: \(investmentPortfolioEquity)
        Investment Portfolio - Bonds: \(investmentPortfolioBonds)
        
        Life Insurance Requirement: \(lifeInsuranceRequirement ?? 0.0)
        """
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("LifeInsuranceData.txt")
        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
            print("Data exported successfully to \(url)")
        } catch {
            print("Failed to export data: \(error.localizedDescription)")
        }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(activityVC, animated: true, completion: nil)
        }
    }
}


struct WhatsYourWorthApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}

*/

/*
 
// this is great but want to make improvement

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var name = ""
    @State private var country = ""
    @State private var currency = ""
    
    // Financial Needs
    @State private var finalExpenses = ""
    @State private var taxesPayable = ""
    @State private var mortgageRetirement = ""
    @State private var otherDebt = ""
    @State private var educationFund = ""
    @State private var emergencyFund = ""
    
    // Living Expenses
    @State private var livingExpensesOwned = ""
    @State private var spouseLivingExpenses = ""
    @State private var child1LivingExpenses = ""
    @State private var child2LivingExpenses = ""
    @State private var parentsLivingExpenses = ""
    
    // Employment Income
    @State private var employmentIncomeOwned = ""
    @State private var spouseEmploymentIncome = ""
    
    // Capital Available
    @State private var cashSavings = ""
    @State private var vestedRetirementAccounts = ""
    @State private var investmentPortfolioEquity = ""
    @State private var investmentPortfolioBonds = ""
    
    // Calculation Results
    @State private var lifeInsuranceRequirement: Double?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Country", text: $country)
                    TextField("Currency", text: $currency)
                }
                
                Section(header: Text("Financial Needs")) {
                    TextField("Final Expenses", text: $finalExpenses)
                    TextField("Taxes Payable", text: $taxesPayable)
                    TextField("Mortgage Retirement", text: $mortgageRetirement)
                    TextField("Other Debt", text: $otherDebt)
                    TextField("Education Fund", text: $educationFund)
                    TextField("Emergency Fund", text: $emergencyFund)
                }
                
                Section(header: Text("Living Expenses")) {
                    TextField("Owned Living Expenses", text: $livingExpensesOwned)
                    TextField("Spouse Living Expenses", text: $spouseLivingExpenses)
                    TextField("Child 1 Living Expenses", text: $child1LivingExpenses)
                    TextField("Child 2 Living Expenses", text: $child2LivingExpenses)
                    TextField("Parents Living Expenses", text: $parentsLivingExpenses)
                }
                
                Section(header: Text("Employment Income")) {
                    TextField("Owned Employment Income", text: $employmentIncomeOwned)
                    TextField("Spouse Employment Income", text: $spouseEmploymentIncome)
                }
                
                Section(header: Text("Capital Available")) {
                    TextField("Cash Savings", text: $cashSavings)
                    TextField("Vested Retirement Accounts", text: $vestedRetirementAccounts)
                    TextField("Investment Portfolio - Equity", text: $investmentPortfolioEquity)
                    TextField("Investment Portfolio - Bonds", text: $investmentPortfolioBonds)
                }
                
                Section {
                    Button(action: calculateLifeInsuranceRequirement) {
                        Text("Calculate Life Insurance Requirement")
                    }
                    
                    Button(action: exportData) {
                        Text("Export Data")
                    }
                }
                
                if let requirement = lifeInsuranceRequirement {
                    Section(header: Text("Life Insurance Requirement")) {
                        Text("S$ \(requirement, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("What's Your Worth?")
        }
    }
    
    // Function to calculate life insurance requirement
    func calculateLifeInsuranceRequirement() {
        let finalExpensesValue = Double(finalExpenses) ?? 0.0
        let taxesPayableValue = Double(taxesPayable) ?? 0.0
        let mortgageRetirementValue = Double(mortgageRetirement) ?? 0.0
        let otherDebtValue = Double(otherDebt) ?? 0.0
        let educationFundValue = Double(educationFund) ?? 0.0
        let emergencyFundValue = Double(emergencyFund) ?? 0.0
        let cashNeeds = finalExpensesValue + taxesPayableValue + mortgageRetirementValue + otherDebtValue + educationFundValue + emergencyFundValue
        
        let livingExpensesOwnedValue = Double(livingExpensesOwned) ?? 0.0
        let spouseLivingExpensesValue = Double(spouseLivingExpenses) ?? 0.0
        let child1LivingExpensesValue = Double(child1LivingExpenses) ?? 0.0
        let child2LivingExpensesValue = Double(child2LivingExpenses) ?? 0.0
        let parentsLivingExpensesValue = Double(parentsLivingExpenses) ?? 0.0
        let capitalNeeds = (livingExpensesOwnedValue * 30) + (spouseLivingExpensesValue * 60) + (child1LivingExpensesValue * 5) + (child2LivingExpensesValue * 5) + (parentsLivingExpensesValue * 20)
        
        let totalFinancialNeeds = cashNeeds + capitalNeeds
        
        let cashSavingsValue = Double(cashSavings) ?? 0.0
        let vestedRetirementAccountsValue = Double(vestedRetirementAccounts) ?? 0.0
        let investmentPortfolioEquityValue = Double(investmentPortfolioEquity) ?? 0.0
        let investmentPortfolioBondsValue = Double(investmentPortfolioBonds) ?? 0.0
        let totalCapitalAvailable = cashSavingsValue + vestedRetirementAccountsValue + investmentPortfolioEquityValue + investmentPortfolioBondsValue
        
        lifeInsuranceRequirement = totalFinancialNeeds - totalCapitalAvailable
    }
    
    // Function to export data
    func exportData() {
        let data = """
        Name: \(name)
        Country: \(country)
        Currency: \(currency)
        
        Financial Needs:
        Final Expenses: \(finalExpenses)
        Taxes Payable: \(taxesPayable)
        Mortgage Retirement: \(mortgageRetirement)
        Other Debt: \(otherDebt)
        Education Fund: \(educationFund)
        Emergency Fund: \(emergencyFund)
        
        Living Expenses:
        Owned: \(livingExpensesOwned)
        Spouse: \(spouseLivingExpenses)
        Child 1: \(child1LivingExpenses)
        Child 2: \(child2LivingExpenses)
        Parents: \(parentsLivingExpenses)
        
        Employment Income:
        Owned: \(employmentIncomeOwned)
        Spouse: \(spouseEmploymentIncome)
        
        Capital Available:
        Cash Savings: \(cashSavings)
        Vested Retirement Accounts: \(vestedRetirementAccounts)
        Investment Portfolio - Equity: \(investmentPortfolioEquity)
        Investment Portfolio - Bonds: \(investmentPortfolioBonds)
        
        Life Insurance Requirement: \(lifeInsuranceRequirement ?? 0.0)
        """
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("LifeInsuranceData.txt")
        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
            print("Data exported successfully to \(url)")
        } catch {
            print("Failed to export data: \(error.localizedDescription)")
        }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(activityVC, animated: true, completion: nil)
        }
    }
}


struct WhatsYourWorthApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}

*/

/*
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
//                .foregroundStyle(.tint)
            Text("What’s Your Worth?")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

*/
