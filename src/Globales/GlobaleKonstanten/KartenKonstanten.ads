pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with StadtKonstanten;
with TextKonstanten;
with ProduktionDatentypen;
with KampfDatentypen;

package KartenKonstanten is
   
   LeerEAchse : constant KartenDatentypen.Ebene := KartenDatentypen.Ebene'First;
   LeerYAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;
   LeerXAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;
   
   LeerEAchseÄnderung : constant KartenDatentypen.EbeneVorhanden := 0;
   LeerYAchseÄnderung : constant KartenDatentypen.KartenfeldPositivMitNullwert := LeerYAchse;
   LeerXAchseÄnderung : constant KartenDatentypen.KartenfeldPositivMitNullwert := LeerXAchse;
   
   -------------------------- Das hier später mal überall einbauen.
   PlaneteninneresKonstante : constant KartenDatentypen.EbeneVorhanden := -2;
   UnterflächeKonstante : constant KartenDatentypen.EbeneVorhanden := -1;
   OberflächeKonstante : constant KartenDatentypen.EbeneVorhanden := 0;
   HimmelKonstante : constant KartenDatentypen.EbeneVorhanden := 1;
   WeltraumKonstante : constant KartenDatentypen.EbeneVorhanden := 2;
   
   LeerKartenGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerWirtschaft : constant ProduktionDatentypen.ProduktionElement := 0;
   LeerKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   
   LeerSichtbar : constant Boolean := False;
   LeerDurchStadtBelegterGrund : constant KartenRecords.BelegterGrundRecord := (StadtKonstanten.LeerRasse, StadtKonstanten.LeerNummer);
   LeerFelderwertung : constant KartenDatentypen.GesamtbewertungFeld := 0;
   
   LeerVerbesserungGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
      
   LeerVerbesserungBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerVerbesserungWirtschaft : constant ProduktionDatentypen.ProduktionElement := 0;
   LeerVerbesserungKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   
   WirtschaftNahrung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Nahrung;
   WirtschaftProduktion : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Produktion;
   WirtschaftGeld : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Geld;
   WirtschaftForschung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Forschung;
   KampfVerteidigung : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Verteidigung;
   KampfAngriff : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Angriff;
   
end KartenKonstanten;
