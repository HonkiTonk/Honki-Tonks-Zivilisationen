pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;

package ProduktionFeld is

   function ProduktionFeldNahrung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;
   
   function ProduktionFeldRessourcen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;
     
   function ProduktionFeldGeld
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;
     
   function ProduktionFeldWissen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;
   
   function ProduktionFeldVerteidigung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;
   
private
   
   GesamtProduktion : GlobaleDatentypen.ProduktionFeld;

end ProduktionFeld;
