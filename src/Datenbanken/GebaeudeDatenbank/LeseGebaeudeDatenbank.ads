pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with DatenbankRecords;

package LeseGebaeudeDatenbank is

   function GebäudeGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return Wide_Wide_Character
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
      
   function PreisGeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function PreisRessourcen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function PermanenteKosten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID;
      WelcheKostenExtern : in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum)
      return GlobaleDatentypen.GesamtePermanenteKosten
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
      
   function Anforderungen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
      
   function PermanenterBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID;
      WelcherBonusExtern : in GlobaleDatentypen.Bonus_Werte_Enum)
      return GlobaleDatentypen.ProduktionFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
      
   function UmgebungBenötigt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.Karten_Grund_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function GanzerEintrag
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return DatenbankRecords.GebäudeListeRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

end LeseGebaeudeDatenbank;
