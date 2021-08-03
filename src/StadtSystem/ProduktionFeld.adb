pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with KartenAllgemein;

package body ProduktionFeld is

   function ProduktionFeldNahrung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundNahrung (PositionExtern => KoordinatenExtern) + KartenAllgemein.RessourceNahrung (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.StraßeNahrung (PositionExtern => KoordinatenExtern) + KartenAllgemein.VerbesserungNahrung (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.FlussNahrung (PositionExtern => KoordinatenExtern);
      
   end ProduktionFeldNahrung;
     
     
     
   function ProduktionFeldRessourcen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundRessourcen (PositionExtern => KoordinatenExtern) + KartenAllgemein.RessourceRessourcen (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.StraßeRessourcen (PositionExtern => KoordinatenExtern) + KartenAllgemein.VerbesserungRessourcen (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.FlussRessourcen (PositionExtern => KoordinatenExtern);
      
   end ProduktionFeldRessourcen;
     
     
     
   function ProduktionFeldGeld
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundGeld (PositionExtern => KoordinatenExtern) + KartenAllgemein.RessourceGeld (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.StraßeGeld (PositionExtern => KoordinatenExtern) + KartenAllgemein.VerbesserungGeld (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.FlussGeld (PositionExtern => KoordinatenExtern);
      
   end ProduktionFeldGeld;
     
     
     
   function ProduktionFeldWissen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundWissen (PositionExtern => KoordinatenExtern) + KartenAllgemein.RessourceWissen (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.StraßeWissen (PositionExtern => KoordinatenExtern) + KartenAllgemein.VerbesserungWissen (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.FlussWissen (PositionExtern => KoordinatenExtern);
      
   end ProduktionFeldWissen;
     
     
     
   function ProduktionFeldVerteidigung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return KartenAllgemein.GrundVerteidigung (PositionExtern => KoordinatenExtern) + KartenAllgemein.RessourceVerteidigung (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.StraßeVerteidigung (PositionExtern => KoordinatenExtern) + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => KoordinatenExtern)
        + KartenAllgemein.FlussVerteidigung (PositionExtern => KoordinatenExtern);
      
   end ProduktionFeldVerteidigung;

end ProduktionFeld;
