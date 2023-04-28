with KartenDatentypen;
with KartenRecords;
with ProduktionDatentypen;
with KampfDatentypen;
with RueckgabeDatentypen;
with KartenartDatentypen;
with BewertungDatentypen;

package KartenKonstanten is
   pragma Pure;
   use type KartenDatentypen.Ebene;
   use type KartenDatentypen.Kartenfeld;
   
   LeerEAchse : constant KartenDatentypen.Ebene := KartenDatentypen.Ebene'First;
   LeerYAchse : constant KartenDatentypen.KartenfeldNatural := KartenDatentypen.KartenfeldNatural'First;
   LeerXAchse : constant KartenDatentypen.KartenfeldNatural := KartenDatentypen.KartenfeldNatural'First;
   
   LeerEAchseÄnderung : constant KartenDatentypen.EbeneVorhanden := 0;
   LeerYAchseÄnderung : constant KartenDatentypen.KartenfeldNatural := LeerYAchse;
   LeerXAchseÄnderung : constant KartenDatentypen.KartenfeldNatural := LeerXAchse;
   
   AnfangEAchse : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'First;
   EndeEAchse : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'Last;
   AnfangYAchse : constant KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AnfangXAchse : constant KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   
   -- Das hier später mal überall einbauen. äöü
   PlaneteninneresKonstante : constant KartenDatentypen.EbeneVorhanden := -2;
   UnterflächeKonstante : constant KartenDatentypen.EbeneVorhanden := -1;
   OberflächeKonstante : constant KartenDatentypen.EbeneVorhanden := 0;
   HimmelKonstante : constant KartenDatentypen.EbeneVorhanden := 1;
   WeltraumKonstante : constant KartenDatentypen.EbeneVorhanden := 2;
   
   LeerPassierbarkeit : constant Boolean := False;
   
   -- Die Bewertung mal in irgendwas mit KIKonstanten packen? äöü
   LeerBewertung : constant BewertungDatentypen.Bewertung_Enum := BewertungDatentypen.Bewertung_Enum'First;
   
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
   
   MinimaleKartengröße : constant KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'Last / 50;
   
   type StandardKartengrößenArray is array (RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range) of KartenRecords.YXAchsenKartenfeldPositivRecord;
   StandardKartengrößen : constant StandardKartengrößenArray := (
                                                                     RueckgabeDatentypen.Auswahl_Eins_Enum   => (KartenDatentypen.KartenfeldPositiv'Last / 50, KartenDatentypen.KartenfeldPositiv'Last / 50),
                                                                     RueckgabeDatentypen.Auswahl_Zwei_Enum   => (KartenDatentypen.KartenfeldPositiv'Last / 25, KartenDatentypen.KartenfeldPositiv'Last / 25),
                                                                     RueckgabeDatentypen.Auswahl_Drei_Enum   => (KartenDatentypen.KartenfeldPositiv'Last / 12, KartenDatentypen.KartenfeldPositiv'Last / 12),
                                                                     RueckgabeDatentypen.Auswahl_Vier_Enum   => (KartenDatentypen.KartenfeldPositiv'Last / 8, KartenDatentypen.KartenfeldPositiv'Last / 12),
                                                                     RueckgabeDatentypen.Auswahl_Fünf_Enum   => (KartenDatentypen.KartenfeldPositiv'Last / 8, KartenDatentypen.KartenfeldPositiv'Last / 6),
                                                                     RueckgabeDatentypen.Auswahl_Sechs_Enum  => (KartenDatentypen.KartenfeldPositiv'Last / 6, KartenDatentypen.KartenfeldPositiv'Last / 6),
                                                                     RueckgabeDatentypen.Auswahl_Sieben_Enum => (KartenDatentypen.KartenfeldPositiv'Last / 4, KartenDatentypen.KartenfeldPositiv'Last / 4),
                                                                     RueckgabeDatentypen.Auswahl_Acht_Enum   => (KartenDatentypen.KartenfeldPositiv'Last / 3, KartenDatentypen.KartenfeldPositiv'Last / 3),
                                                                     RueckgabeDatentypen.Auswahl_Neun_Enum   => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last)
                                                                    );
   
   StandardKartenart : constant KartenartDatentypen.Kartenart_Normal_Enum := KartenartDatentypen.Kartenart_Kontinente_Enum;
   
end KartenKonstanten;
