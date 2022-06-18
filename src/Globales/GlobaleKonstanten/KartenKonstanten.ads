pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with StadtKonstanten;
with TextKonstanten;
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
   
   -------------------------- Das hier später mal überall einbauen.
   PlaneteninneresKonstante : constant KartenDatentypen.EbeneVorhanden := -2;
   UnterflächeKonstante : constant KartenDatentypen.EbeneVorhanden := -1;
   OberflächeKonstante : constant KartenDatentypen.EbeneVorhanden := 0;
   HimmelKonstante : constant KartenDatentypen.EbeneVorhanden := 1;
   WeltraumKonstante : constant KartenDatentypen.EbeneVorhanden := 2;
   
   LeerKartenGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerBewertung : constant KartenDatentypen.Einzelbewertung := 0;
   LeerWirtschaft : constant ProduktionDatentypen.Einzelproduktion := 0;
   LeerKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   
   LeerSichtbar : constant Boolean := False;
   LeerDurchStadtBelegterGrund : constant KartenRecords.BelegterGrundRecord := (StadtKonstanten.LeerRasse, StadtKonstanten.LeerNummer);
   LeerFelderwertung : constant KartenDatentypen.GesamteFeldbewertung := 0;
   
   LeerVerbesserungGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
      
   LeerVerbesserungBewertung : constant KartenDatentypen.Einzelbewertung := 0;
   LeerVerbesserungWirtschaft : constant ProduktionDatentypen.Einzelproduktion := 0;
   LeerVerbesserungKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   
   WirtschaftNahrung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Nahrung;
   WirtschaftProduktion : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Produktion;
   WirtschaftGeld : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Geld;
   WirtschaftForschung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Forschung;
   KampfVerteidigung : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Verteidigung;
   KampfAngriff : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Angriff;
   
   type StandardKartengrößenArray is array (RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range) of KartenRecords.YXAchsenKartenfeldPositivRecord;
   StandardKartengrößen : constant StandardKartengrößenArray := (
                                                                     RueckgabeDatentypen.Kartengröße_20_20_Enum     => (20, 20),
                                                                     RueckgabeDatentypen.Kartengröße_40_40_Enum     => (40, 40),
                                                                     RueckgabeDatentypen.Kartengröße_80_80_Enum     => (80, 80),
                                                                     RueckgabeDatentypen.Kartengröße_120_80_Enum    => (120, 80),
                                                                     RueckgabeDatentypen.Kartengröße_120_160_Enum   => (120, 160),
                                                                     RueckgabeDatentypen.Kartengröße_160_160_Enum   => (160, 160),
                                                                     RueckgabeDatentypen.Kartengröße_240_240_Enum   => (240, 240),
                                                                     RueckgabeDatentypen.Kartengröße_320_320_Enum   => (320, 320),
                                                                     RueckgabeDatentypen.Kartengröße_1000_1000_Enum => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last)
                                                                    );
   
   StandardKartenart : constant KartenDatentypen.Kartenart_Normal_Enum := KartenDatentypen.Kartenart_Inseln_Enum;
   
end KartenKonstanten;
