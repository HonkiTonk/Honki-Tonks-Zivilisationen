pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with Weltkarte;

private with KartengrundDatentypen;

package FlussplatzierungssystemLogik is
   pragma Elaborate_Body;
   
   procedure Flussplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
private
   
   type StandardFlussArray is array (KartenDatentypen.EbeneVorhanden'First .. 0) of KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   -2 => KartengrundDatentypen.Lavasee_Enum,
                                                   -1 => KartengrundDatentypen.Unterirdischer_See_Enum,
                                                   0  => KartengrundDatentypen.See_Enum
                                                  );
   
   type WelcherFlussArray is array (StandardFlussArray'Range) of KartengrundDatentypen.Kartenfluss_Enum;
   WelcherFluss : WelcherFlussArray;
   
   type KartenWertArray is array (StandardFlussArray'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenWertArray;
   
   type FlusstypArray is array (StandardFlussArray'Range) of Natural;
   Flusstyp : constant FlusstypArray := (
                                         -2 =>
                                           KartengrundDatentypen.Kartenfluss_Kern_Enum'Pos (KartengrundDatentypen.Lavaflusskreuzung_Vier_Enum)
                                         - KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                       
                                         -1 =>
                                           KartengrundDatentypen.Kartenfluss_Unterfläche_Enum'Pos (KartengrundDatentypen.Unterirdische_Flusskreuzung_Vier_Enum)
                                         - KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                         
                                         0  => 0
                                        );
   
   type FlussseiteArray is array (StandardFlussArray'Range) of Boolean;
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
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Fluss_Waagrecht_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Links_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Links_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Rechts_Enum)
                                                   )
                                                )
                                             ),
                                           
                                           False =>
                                             (
                                              True =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Links_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Fluss_Senkrecht_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Unten_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Oben_Enum),
                                                    False => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.See_Enum)
                                                   )
                                                )
                                             )
                                          );
   
   type FlussSeitenArray is array (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Range) of Natural;
   FlüsseLinks : constant FlussSeitenArray := (
                                                KartengrundDatentypen.Fluss_Senkrecht_Enum          => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartengrundDatentypen.Flusskurve_Unten_Links_Enum   => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                KartengrundDatentypen.Flusskurve_Oben_Links_Enum    => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                KartengrundDatentypen.Flussendstück_Rechts_Enum     => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Fluss_Waagrecht_Enum),
                                                KartengrundDatentypen.Flussendstück_Unten_Enum      => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartengrundDatentypen.Flussendstück_Oben_Enum       => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                KartengrundDatentypen.See_Enum                      => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Links_Enum),
                                                others => 0
                                               );
   
   FlüsseRechts : constant FlussSeitenArray := (
                                                 KartengrundDatentypen.Fluss_Senkrecht_Enum           => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                 KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum   => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                 KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum    => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                 KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                 KartengrundDatentypen.Flussendstück_Links_Enum       => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Fluss_Waagrecht_Enum),
                                                 KartengrundDatentypen.Flussendstück_Unten_Enum       => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Links_Enum),
                                                 KartengrundDatentypen.Flussendstück_Oben_Enum        => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Links_Enum),
                                                 KartengrundDatentypen.See_Enum                       => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Rechts_Enum),
                                                 others => 0
                                                );
   
   FlüsseOben : constant FlussSeitenArray := (
                                               KartengrundDatentypen.Fluss_Waagrecht_Enum         => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                               KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                               KartengrundDatentypen.Flusskurve_Oben_Links_Enum   => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                               KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                               KartengrundDatentypen.Flussendstück_Links_Enum     => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum),
                                               KartengrundDatentypen.Flussendstück_Rechts_Enum    => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Unten_Links_Enum),
                                               KartengrundDatentypen.Flussendstück_Unten_Enum     => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Fluss_Senkrecht_Enum),
                                               KartengrundDatentypen.See_Enum                     => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Oben_Enum),
                                               others => 0
                                              );
   
   FlüsseUnten : constant FlussSeitenArray := (
                                                KartengrundDatentypen.Fluss_Waagrecht_Enum          => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum  => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartengrundDatentypen.Flusskurve_Unten_Links_Enum   => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskreuzung_Vier_Enum),
                                                KartengrundDatentypen.Flussendstück_Links_Enum      => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartengrundDatentypen.Flussendstück_Rechts_Enum     => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flusskurve_Oben_Links_Enum),
                                                KartengrundDatentypen.Flussendstück_Oben_Enum       => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Fluss_Senkrecht_Enum),
                                                KartengrundDatentypen.See_Enum                      => KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (KartengrundDatentypen.Flussendstück_Unten_Enum),
                                                others => 0
                                               );
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
end FlussplatzierungssystemLogik;
