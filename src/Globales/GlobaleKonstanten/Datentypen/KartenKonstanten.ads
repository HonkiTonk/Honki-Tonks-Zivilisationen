with KartenDatentypen;
with KartenRecords;
with RueckgabeDatentypen;
with KartenartDatentypen;

package KartenKonstanten is
   pragma Pure;
   use type KartenDatentypen.Ebene;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   LeerEbene : constant KartenDatentypen.Ebene := KartenDatentypen.Ebene'First;
   LeerSenkrechte : constant KartenDatentypen.SenkrechteNatural := KartenDatentypen.SenkrechteNatural'First;
   LeerWaagerechte : constant KartenDatentypen.WaagerechteNatural := KartenDatentypen.WaagerechteNatural'First;
   
   LeerEbeneÄnderung : constant KartenDatentypen.EbeneVorhanden := 0;
   LeerSenkrechteÄnderung : constant KartenDatentypen.SenkrechteNatural := LeerSenkrechte;
   LeerWaagerechteÄnderung : constant KartenDatentypen.WaagerechteNatural := LeerWaagerechte;
   
   EbeneHoch : constant KartenDatentypen.EbeneVorhanden := 1;
   EbeneRunter : constant KartenDatentypen.EbeneVorhanden := -1;
   SenkrechteNorden : constant KartenDatentypen.SenkrechteUmgebungEins := -1;
   SenkrechteSüden : constant KartenDatentypen.SenkrechteUmgebungEins := 1;
   WaagerechteWesten : constant KartenDatentypen.WaagerechteUmgebungEins := -1;
   WaagerechteOsten : constant KartenDatentypen.WaagerechteUmgebungEins := 1;
   
   AnfangEbene : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'First;
   EndeEbene : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'Last;
   AnfangSenkrechte : constant KartenDatentypen.SenkrechtePositiv := KartenDatentypen.SenkrechtePositiv'First;
   AnfangWaagerechte : constant KartenDatentypen.WaagerechtePositiv := KartenDatentypen.WaagerechtePositiv'First;
   
   PlaneteninneresKonstante : constant KartenDatentypen.EbeneVorhanden := -2;
   UnterflächeKonstante : constant KartenDatentypen.EbeneVorhanden := -1;
   OberflächeKonstante : constant KartenDatentypen.EbeneVorhanden := 0;
   HimmelKonstante : constant KartenDatentypen.EbeneVorhanden := 1;
   WeltraumKonstante : constant KartenDatentypen.EbeneVorhanden := 2;
   
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerSichtbar : constant Boolean := False;
   
   MinimaleKartengröße : constant KartenRecords.KartenfeldumgebungPositivRecord := (
                                                                                      Senkrechte => KartenDatentypen.SenkrechtePositiv'Last / 50,
                                                                                      Waagerechte => KartenDatentypen.WaagerechtePositiv'Last / 50
                                                                                     );
   
   type StandardKartengrößenArray is array (RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range) of KartenRecords.KartenfeldumgebungPositivRecord;
   StandardKartengrößen : constant StandardKartengrößenArray := (
                                                                     RueckgabeDatentypen.Auswahl_Eins_Enum   => (KartenDatentypen.SenkrechtePositiv'Last / 50, KartenDatentypen.WaagerechtePositiv'Last / 50),
                                                                     RueckgabeDatentypen.Auswahl_Zwei_Enum   => (KartenDatentypen.SenkrechtePositiv'Last / 25, KartenDatentypen.WaagerechtePositiv'Last / 25),
                                                                     RueckgabeDatentypen.Auswahl_Drei_Enum   => (KartenDatentypen.SenkrechtePositiv'Last / 12, KartenDatentypen.WaagerechtePositiv'Last / 12),
                                                                     RueckgabeDatentypen.Auswahl_Vier_Enum   => (KartenDatentypen.SenkrechtePositiv'Last / 8, KartenDatentypen.WaagerechtePositiv'Last / 12),
                                                                     RueckgabeDatentypen.Auswahl_Fünf_Enum   => (KartenDatentypen.SenkrechtePositiv'Last / 8, KartenDatentypen.WaagerechtePositiv'Last / 6),
                                                                     RueckgabeDatentypen.Auswahl_Sechs_Enum  => (KartenDatentypen.SenkrechtePositiv'Last / 6, KartenDatentypen.WaagerechtePositiv'Last / 6),
                                                                     RueckgabeDatentypen.Auswahl_Sieben_Enum => (KartenDatentypen.SenkrechtePositiv'Last / 4, KartenDatentypen.WaagerechtePositiv'Last / 4),
                                                                     RueckgabeDatentypen.Auswahl_Acht_Enum   => (KartenDatentypen.SenkrechtePositiv'Last / 3, KartenDatentypen.WaagerechtePositiv'Last / 3),
                                                                     RueckgabeDatentypen.Auswahl_Neun_Enum   => (KartenDatentypen.SenkrechtePositiv'Last, KartenDatentypen.WaagerechtePositiv'Last)
                                                                    );
   
   StandardKartenart : constant KartenartDatentypen.Kartenart_Normal_Enum := KartenartDatentypen.Kartenart_Kontinente_Enum;
   
end KartenKonstanten;
