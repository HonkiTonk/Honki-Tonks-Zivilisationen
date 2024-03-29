with KartenDatentypen;
with KartenRecords;
with RueckgabeDatentypen;
with KartenartDatentypen;

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
   
   EbeneHoch : constant KartenDatentypen.EbeneVorhanden := 1;
   EbeneRunter : constant KartenDatentypen.EbeneVorhanden := -1;
   YAchseNorden : constant KartenDatentypen.UmgebungsbereichEins := -1;
   YAchseSüden : constant KartenDatentypen.UmgebungsbereichEins := 1;
   XAchseWesten : constant KartenDatentypen.UmgebungsbereichEins := -1;
   XAchseOsten : constant KartenDatentypen.UmgebungsbereichEins := 1;
   
   AnfangEAchse : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'First;
   EndeEAchse : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'Last;
   AnfangYAchse : constant KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AnfangXAchse : constant KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   
   PlaneteninneresKonstante : constant KartenDatentypen.EbeneVorhanden := -2;
   UnterflächeKonstante : constant KartenDatentypen.EbeneVorhanden := -1;
   OberflächeKonstante : constant KartenDatentypen.EbeneVorhanden := 0;
   HimmelKonstante : constant KartenDatentypen.EbeneVorhanden := 1;
   WeltraumKonstante : constant KartenDatentypen.EbeneVorhanden := 2;
   
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerSichtbar : constant Boolean := False;
   
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
