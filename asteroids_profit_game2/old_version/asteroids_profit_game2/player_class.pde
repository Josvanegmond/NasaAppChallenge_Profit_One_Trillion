class Player{
  float totalProfit = 0;
  
  int playerX = 0;
  int playerY = 0;
  
  Player(String name){

  }
  
  void addProfit(float addSum){
    totalProfit+=addSum;
  }
  
  float getProfit(){
    return totalProfit;
  }
  

}
