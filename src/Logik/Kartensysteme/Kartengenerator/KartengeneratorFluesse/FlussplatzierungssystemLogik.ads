with KartenDatentypen;
with KartenRecords;

private with KartenKonstanten;
private with KartenextraDatentypen;

with LeseWeltkarteneinstellungen;

package FlussplatzierungssystemLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   
   procedure Flussplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   use type KartenDatentypen.Ebene;
   
   WelcherFluss : KartenextraDatentypen.Fluss_Enum;
   
   Flussseite : KartenRecords.UmgebungskreuzRecord;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type StandardFlussArray is array (KartenDatentypen.EbenePlanet'Range) of KartenextraDatentypen.Fluss_Vorhanden_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   KartenKonstanten.PlaneteninneresKonstante => KartenextraDatentypen.Lavasee_Enum,
                                                   KartenKonstanten.UnterflächeKonstante     => KartenextraDatentypen.Unterirdischer_See_Enum,
                                                   KartenKonstanten.OberflächeKonstante      => KartenextraDatentypen.See_Enum
                                                  );
   
   type FlusstypArray is array (StandardFlussArray'Range) of Natural;
   Flusstyp : constant FlusstypArray := (
                                         KartenKonstanten.PlaneteninneresKonstante =>
                                           KartenextraDatentypen.Fluss_Kernfläche_Enum'Pos (KartenextraDatentypen.Lavaflusskreuzung_Vier_Enum)
                                         - KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Vier_Enum),
                                                       
                                         KartenKonstanten.UnterflächeKonstante =>
                                           KartenextraDatentypen.Fluss_Unterfläche_Enum'Pos (KartenextraDatentypen.Unterirdische_Flusskreuzung_Vier_Enum)
                                         - KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Vier_Enum),
                                         
                                         KartenKonstanten.OberflächeKonstante  => 0
                                        );
   
   type FlusswertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Positive;
   Flusswert : constant FlusswertArray := (
                                           True =>
                                             (
                                              True =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Vier_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Fluss_Waagrecht_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Oben_Links_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Unten_Links_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Rechts_Enum)
                                                   )
                                                )
                                             ),
                                           
                                           False =>
                                             (
                                              True =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Oben_Rechts_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Links_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Fluss_Senkrecht_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Unten_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Oben_Enum),
                                                    False => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.See_Enum)
                                                   )
                                                )
                                             )
                                          );
   
   type FlussSeitenArray is array (KartenextraDatentypen.Fluss_Oberfläche_Enum'Range) of Natural;
   FlüsseLinks : constant FlussSeitenArray := (
                                                KartenextraDatentypen.Fluss_Senkrecht_Enum          => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartenextraDatentypen.Flusskurve_Unten_Links_Enum   => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                KartenextraDatentypen.Flusskurve_Oben_Links_Enum    => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartenextraDatentypen.Flusskreuzung_Drei_Links_Enum => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Vier_Enum),
                                                KartenextraDatentypen.Flussendstück_Rechts_Enum     => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Fluss_Waagrecht_Enum),
                                                KartenextraDatentypen.Flussendstück_Unten_Enum      => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartenextraDatentypen.Flussendstück_Oben_Enum       => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                KartenextraDatentypen.See_Enum                      => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Links_Enum),
                                                others                                              => 0
                                               );
   
   FlüsseRechts : constant FlussSeitenArray := (
                                                 KartenextraDatentypen.Fluss_Senkrecht_Enum           => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                 KartenextraDatentypen.Flusskurve_Unten_Rechts_Enum   => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                 KartenextraDatentypen.Flusskurve_Oben_Rechts_Enum    => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                 KartenextraDatentypen.Flusskreuzung_Drei_Rechts_Enum => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Vier_Enum),
                                                 KartenextraDatentypen.Flussendstück_Links_Enum       => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Fluss_Waagrecht_Enum),
                                                 KartenextraDatentypen.Flussendstück_Unten_Enum       => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Oben_Links_Enum),
                                                 KartenextraDatentypen.Flussendstück_Oben_Enum        => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Unten_Links_Enum),
                                                 KartenextraDatentypen.See_Enum                       => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Rechts_Enum),
                                                 others                                               => 0
                                                );
   
   FlüsseOben : constant FlussSeitenArray := (
                                               KartenextraDatentypen.Fluss_Waagrecht_Enum         => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                               KartenextraDatentypen.Flusskurve_Oben_Rechts_Enum  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                               KartenextraDatentypen.Flusskurve_Oben_Links_Enum   => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Links_Enum),
                                               KartenextraDatentypen.Flusskreuzung_Drei_Oben_Enum => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Vier_Enum),
                                               KartenextraDatentypen.Flussendstück_Links_Enum     => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Unten_Rechts_Enum),
                                               KartenextraDatentypen.Flussendstück_Rechts_Enum    => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Unten_Links_Enum),
                                               KartenextraDatentypen.Flussendstück_Unten_Enum     => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Fluss_Senkrecht_Enum),
                                               KartenextraDatentypen.See_Enum                     => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Oben_Enum),
                                               others                                             => 0
                                              );
   
   FlüsseUnten : constant FlussSeitenArray := (
                                                KartenextraDatentypen.Fluss_Waagrecht_Enum          => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartenextraDatentypen.Flusskurve_Unten_Rechts_Enum  => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartenextraDatentypen.Flusskurve_Unten_Links_Enum   => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                KartenextraDatentypen.Flusskreuzung_Drei_Unten_Enum => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskreuzung_Vier_Enum),
                                                KartenextraDatentypen.Flussendstück_Links_Enum      => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartenextraDatentypen.Flussendstück_Rechts_Enum     => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flusskurve_Oben_Links_Enum),
                                                KartenextraDatentypen.Flussendstück_Oben_Enum       => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Fluss_Senkrecht_Enum),
                                                KartenextraDatentypen.See_Enum                      => KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (KartenextraDatentypen.Flussendstück_Unten_Enum),
                                                others                                              => 0
                                               );
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
end FlussplatzierungssystemLogik;
