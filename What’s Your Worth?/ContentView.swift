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
