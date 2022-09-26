pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with ProduktionDatentypen;
with KampfDatentypen;
with RueckgabeDatentypen;

package KartenKonstanten is
   
   LeerEAchse : constant KartenDatentypen.Ebene := KartenDatentypen.Ebene'First;
   LeerYAchse : constant KartenDatentypen.KartenfeldNatural := KartenDatentypen.KartenfeldNatural'First;
   LeerXAchse : constant KartenDatentypen.KartenfeldNatural := KartenDatentypen.KartenfeldNatural'First;
   
   LeerEAchseÄnderung : constant KartenDatentypen.EbeneVorhanden := 0;
   LeerYAchseÄnderung : constant KartenDatentypen.KartenfeldNatural := LeerYAchse;
   LeerXAchseÄnderung : constant KartenDatentypen.KartenfeldNatural := LeerXAchse;
   
   -- Das hier später mal überall einbauen. äöü
   PlaneteninneresKonstante : constant KartenDatentypen.EbeneVorhanden := -2;
   UnterflächeKonstante : constant KartenDatentypen.EbeneVorhanden := -1;
   OberflächeKonstante : constant KartenDatentypen.EbeneVorhanden := 0;
   HimmelKonstante : constant KartenDatentypen.EbeneVorhanden := 1;
   WeltraumKonstante : constant KartenDatentypen.EbeneVorhanden := 2;
   
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerBewertung : constant KartenDatentypen.Einzelbewertung := 0;
   LeerFeldwertung : constant KartenDatentypen.Bewertung_Enum := KartenDatentypen.Null_Enum;
   LeerWirtschaft : constant ProduktionDatentypen.Einzelproduktion := 0;
   LeerKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   
   LeerSichtbar : constant Boolean := False;
   LeerFelderwertung : constant KartenDatentypen.GesamteFeldbewertung := 0;
         
   LeerVerbesserungBewertung : constant KartenDatentypen.Einzelbewertung := 0;
   LeerVerbesserungWirtschaft : constant ProduktionDatentypen.Einzelproduktion := 0;
   LeerVerbesserungKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   
   WirtschaftNahrung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Nahrung_Enum;
   WirtschaftProduktion : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Produktion_Enum;
   WirtschaftGeld : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Geld_Enum;
   WirtschaftForschung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Forschung_Enum;
   KampfVerteidigung : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Verteidigung_Enum;
   KampfAngriff : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Angriff_Enum;
   
   type StandardKartengrößenArray is array (RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range) of KartenRecords.YXAchsenKartenfeldPositivRecord;
   StandardKartengrößen : constant StandardKartengrößenArray := (
                                                                     RueckgabeDatentypen.Auswahl_Eins_Enum   => (20, 20),
                                                                     RueckgabeDatentypen.Auswahl_Zwei_Enum   => (40, 40),
                                                                     RueckgabeDatentypen.Auswahl_Drei_Enum   => (80, 80),
                                                                     RueckgabeDatentypen.Auswahl_Vier_Enum   => (120, 80),
                                                                     RueckgabeDatentypen.Auswahl_Fünf_Enum   => (120, 160),
                                                                     RueckgabeDatentypen.Auswahl_Sechs_Enum  => (160, 160),
                                                                     RueckgabeDatentypen.Auswahl_Sieben_Enum => (240, 240),
                                                                     RueckgabeDatentypen.Auswahl_Acht_Enum   => (320, 320),
                                                                     RueckgabeDatentypen.Auswahl_Neun_Enum   => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last)
                                                                    );
   
   StandardKartenart : constant KartenDatentypen.Kartenart_Normal_Enum := KartenDatentypen.Kartenart_Kontinente_Enum;
   
end KartenKonstanten;
