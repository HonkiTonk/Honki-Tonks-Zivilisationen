pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;

with Karten;

package KartengeneratorFluss is

   procedure AufteilungFlussgenerierung;

private
   
   ------------------- Später vom Nutzer änderbar machen.
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbeneVorhanden'First .. 0) of Float;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                      -2 => 0.30,
                                                                      -1 => 0.30,
                                                                      0  => 0.30
                                                                     );
   
   type StandardFlussArray is array (WahrscheinlichkeitFlussArray'Range) of KartengrundDatentypen.Karten_Fluss_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   -2 => KartengrundDatentypen.Lavasee_Enum,
                                                   -1 => KartengrundDatentypen.Unterirdischer_See_Enum,
                                                   0  => KartengrundDatentypen.See_Enum
                                                  );
   
   type FlusstypArray is array (WahrscheinlichkeitFlussArray'Range) of Natural;
   Flusstyp : constant FlusstypArray := (
                                         -2 => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Lavaflusskreuzung_Vier_Enum)
                                         - KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                       
                                         -1 => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Unterirdische_Flusskreuzung_Vier_Enum)
                                         - KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                         
                                         0  => 0
                                        );
   
   type FlussseiteArray is array (WahrscheinlichkeitFlussArray'Range) of Boolean;
   FlussLinks : FlussseiteArray;
   FlussRechts : FlussseiteArray;
   FlussOben : FlussseiteArray;
   FlussUnten : FlussseiteArray;
   
   type FlusswertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Natural;
   Flusswert : constant FlusswertArray := (
                                           True =>
                                             (
                                              True =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Fluss_Waagrecht_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Links_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Links_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flussendstück_Rechts_Enum)
                                                   )
                                                )
                                             ),
                                           
                                           False =>
                                             (
                                              True =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flussendstück_Links_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Fluss_Senkrecht_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flussendstück_Unten_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.Flussendstück_Oben_Enum),
                                                    False => KartengrundDatentypen.Karten_Fluss_Enum'Pos (KartengrundDatentypen.See_Enum)
                                                   )
                                                )
                                             )
                                          );
   
   type FlussSeitenArray is array (KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Range) of Natural;
   FlüsseLinks : constant FlussSeitenArray := (
                                                KartengrundDatentypen.Fluss_Senkrecht_Enum          => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartengrundDatentypen.Flusskurve_Unten_Links_Enum   => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                KartengrundDatentypen.Flusskurve_Oben_Links_Enum    => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                KartengrundDatentypen.Flussendstück_Rechts_Enum     => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Fluss_Waagrecht_Enum),
                                                KartengrundDatentypen.Flussendstück_Unten_Enum      => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartengrundDatentypen.Flussendstück_Oben_Enum       => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                KartengrundDatentypen.See_Enum                      => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flussendstück_Links_Enum),
                                                others => 0
                                               );
   
   FlüsseRechts : constant FlussSeitenArray := (
                                                 KartengrundDatentypen.Fluss_Senkrecht_Enum           => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                 KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum   => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                 KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum    => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                 KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                 KartengrundDatentypen.Flussendstück_Links_Enum       => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Fluss_Waagrecht_Enum),
                                                 KartengrundDatentypen.Flussendstück_Unten_Enum       => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Links_Enum),
                                                 KartengrundDatentypen.Flussendstück_Oben_Enum        => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Links_Enum),
                                                 KartengrundDatentypen.See_Enum                       => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flussendstück_Rechts_Enum),
                                                 others => 0
                                                );
   
   FlüsseOben : constant FlussSeitenArray := (
                                               KartengrundDatentypen.Fluss_Waagrecht_Enum         => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                               KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum  => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                               KartengrundDatentypen.Flusskurve_Oben_Links_Enum   => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                               KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                               KartengrundDatentypen.Flussendstück_Links_Enum     => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum),
                                               KartengrundDatentypen.Flussendstück_Rechts_Enum    => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Links_Enum),
                                               KartengrundDatentypen.Flussendstück_Unten_Enum     => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Fluss_Senkrecht_Enum),
                                               KartengrundDatentypen.See_Enum                     => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flussendstück_Oben_Enum),
                                               others => 0
                                              );
   
   FlüsseUnten : constant FlussSeitenArray := (
                                                KartengrundDatentypen.Fluss_Waagrecht_Enum          => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum  => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartengrundDatentypen.Flusskurve_Unten_Links_Enum   => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                KartengrundDatentypen.Flussendstück_Links_Enum      => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartengrundDatentypen.Flussendstück_Rechts_Enum     => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Links_Enum),
                                                KartengrundDatentypen.Flussendstück_Oben_Enum       => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Fluss_Senkrecht_Enum),
                                                KartengrundDatentypen.See_Enum                      => KartengrundDatentypen.Karten_Fluss_Vorhanden_Enum'Pos (KartengrundDatentypen.Flussendstück_Unten_Enum),
                                                others => 0
                                               );
   
   type BeliebigerFlusswertArray is array (WahrscheinlichkeitFlussArray'Range) of Float;
   BeliebigerFlusswert : BeliebigerFlusswertArray;

   type KartenWertArray is array (WahrscheinlichkeitFlussArray'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenWertArray;
   KartenWertTesten : KartenWertArray;
   
   type WelcherFlussArray is array (WahrscheinlichkeitFlussArray'Range) of KartengrundDatentypen.Karten_Fluss_Enum;
   WelcherFluss : WelcherFlussArray;
   
   procedure GenerierungFlüsse;
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure FlussUmgebungTesten
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure FlussBerechnung
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BerechnungLinks
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungRechts
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungOben
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure BerechnungUnten
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure FlussPlatzieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorFluss;
