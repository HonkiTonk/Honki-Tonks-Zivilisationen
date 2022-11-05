pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with ProduktionDatentypen;
with KampfDatentypen;
with RueckgabeDatentypen;
with KartenartDatentypen;
with BewertungDatentypen;

package KartenKonstanten is
   pragma Pure;
   
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
   
   -- Die Bewertung mal in irgendwas mit KIKonstanten packen? äöü
   LeerBewertung : constant BewertungDatentypen.Bewertung_Enum := BewertungDatentypen.Bewertung_Enum'First;
   LeerWirtschaft : constant ProduktionDatentypen.Einzelproduktion := ProduktionDatentypen.Einzelproduktion'First;
   LeerKampf : constant KampfDatentypen.KampfwerteKarte := KampfDatentypen.KampfwerteEinheiten'First;
   
   LeerSichtbar : constant Boolean := False;
         
   LeerVerbesserungBewertung : constant BewertungDatentypen.Bewertung_Enum := BewertungDatentypen.Bewertung_Enum'First;
   LeerVerbesserungWirtschaft : constant ProduktionDatentypen.Einzelproduktion := ProduktionDatentypen.Einzelproduktion'First;
   LeerVerbesserungKampf : constant KampfDatentypen.KampfwerteKarte := KampfDatentypen.KampfwerteEinheiten'First;
   
   WirtschaftNahrung : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Nahrung_Enum;
   WirtschaftProduktion : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Produktion_Enum;
   WirtschaftGeld : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Geld_Enum;
   WirtschaftForschung : constant ProduktionDatentypen.Wirtschaft_Enum := ProduktionDatentypen.Forschung_Enum;
   KampfVerteidigung : constant KampfDatentypen.Kampf_Enum := KampfDatentypen.Verteidigung_Enum;
   KampfAngriff : constant KampfDatentypen.Kampf_Enum := KampfDatentypen.Angriff_Enum;
   
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
   
   StandardKartenart : constant KartenartDatentypen.Kartenart_Normal_Enum := KartenartDatentypen.Kartenart_Kontinente_Enum;
   
end KartenKonstanten;
