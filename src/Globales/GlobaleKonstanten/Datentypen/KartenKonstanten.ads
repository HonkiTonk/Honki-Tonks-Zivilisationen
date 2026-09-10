with KartenDatentypen;
with KartenRecords;
with RueckgabeDatentypen;
with KartenartDatentypen;

package KartenKonstanten is
   pragma Pure;
   use type KartenDatentypen.EbeneBasis;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   LeerEbene : constant KartenDatentypen.EbeneBasis := KartenDatentypen.EbeneBasis'First;
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
   
   -- Die Ebenenkonstanten hier noch einmal besser benennen? Nach der letzten Änderung ergeben ihre Namen nicht mehr wirklich Sinn. äöü
   AnfangEbene : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'First;
   EndeEbene : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'Last;
   AnfangSenkrechte : constant KartenDatentypen.SenkrechtePositiv := KartenDatentypen.SenkrechtePositiv'First;
   AnfangWaagerechte : constant KartenDatentypen.WaagerechtePositiv := KartenDatentypen.WaagerechtePositiv'First;
   
   KernKonstante : constant KartenDatentypen.EbeneVorhanden := -2;
   UnterflächeKonstante : constant KartenDatentypen.EbeneVorhanden := -1;
   OberflächeKonstante : constant KartenDatentypen.EbeneVorhanden := 0;
   HimmelKonstante : constant KartenDatentypen.EbeneVorhanden := 1;
   OrbitKonstante : constant KartenDatentypen.EbeneVorhanden := 2;
   
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerSichtbar : constant Boolean := False;
   
   MinimaleKartengröße : constant KartenRecords.KartenfeldumgebungPositivRecord := (
                                                                                      Senkrechte  => 20,
                                                                                      Waagerechte => 20
                                                                                     );
   
   type StandardKartengrößenArray is array (RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range) of KartenRecords.KartenfeldumgebungPositivRecord;
   StandardKartengrößen : constant StandardKartengrößenArray := (
                                                                     RueckgabeDatentypen.Auswahl_Eins_Enum   => (20, 20),
                                                                     RueckgabeDatentypen.Auswahl_Zwei_Enum   => (40, 40),
                                                                     RueckgabeDatentypen.Auswahl_Drei_Enum   => (80, 80),
                                                                     RueckgabeDatentypen.Auswahl_Vier_Enum   => (80, 125),
                                                                     RueckgabeDatentypen.Auswahl_Fünf_Enum   => (125, 170),
                                                                     RueckgabeDatentypen.Auswahl_Sechs_Enum  => (170, 170),
                                                                     RueckgabeDatentypen.Auswahl_Sieben_Enum => (250, 250),
                                                                     RueckgabeDatentypen.Auswahl_Acht_Enum   => (350, 350),
                                                                     RueckgabeDatentypen.Auswahl_Neun_Enum   => (1_000, 1_000),
                                                                     RueckgabeDatentypen.Auswahl_Zehn_Enum   => (KartenDatentypen.SenkrechtePositiv'Last, KartenDatentypen.WaagerechtePositiv'Last)
                                                                    );
   
   StandardKartenart : constant KartenartDatentypen.Kartenart_Normal_Enum := KartenartDatentypen.Kartenart_Kontinente_Enum;
   
end KartenKonstanten;
