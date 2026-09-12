with KartenDatentypen;
with KartenRecords;

private with KartenKonstanten;
private with KartenfluesseDatentypen;

with LeseWeltkarteneinstellungen;

package FlussplatzierungssystemLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   procedure Flussplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   WelcherFluss : KartenfluesseDatentypen.Fluss_Enum;
   
   Flussseite : KartenRecords.UmgebungskreuzRecord;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   type StandardFlussArray is array (KartenDatentypen.EbenePlanet'Range) of KartenfluesseDatentypen.Fluss_Vorhanden_Enum;
   StandardFluss : constant StandardFlussArray := (
                                                   KartenKonstanten.KernKonstante => KartenfluesseDatentypen.Lavasee_Enum,
                                                   KartenKonstanten.UnterflächeKonstante     => KartenfluesseDatentypen.Unterirdischer_See_Enum,
                                                   KartenKonstanten.OberflächeKonstante      => KartenfluesseDatentypen.See_Enum
                                                  );
   
   type FlusstypArray is array (StandardFlussArray'Range) of Natural;
   Flusstyp : constant FlusstypArray := (
                                         KartenKonstanten.KernKonstante =>
                                           KartenfluesseDatentypen.Fluss_Kernfläche_Enum'Pos (KartenfluesseDatentypen.Lavaflusskreuzung_Vier_Enum)
                                         - KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Vier_Enum),
                                                       
                                         KartenKonstanten.UnterflächeKonstante =>
                                           KartenfluesseDatentypen.Fluss_Unterfläche_Enum'Pos (KartenfluesseDatentypen.Unterirdische_Flusskreuzung_Vier_Enum)
                                         - KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Vier_Enum),
                                         
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
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Vier_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Oben_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Fluss_Waagrecht_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Oben_Links_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Unten_Links_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Rechts_Enum)
                                                   )
                                                )
                                             ),
                                           
                                           False =>
                                             (
                                              True =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Oben_Rechts_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Links_Enum)
                                                   )
                                                ),
                                              
                                              False =>
                                                (
                                                 True =>
                                                   (
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Fluss_Senkrecht_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Unten_Enum)
                                                   ),
                                                 
                                                 False =>
                                                   (
                                                    True  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Oben_Enum),
                                                    False => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.See_Enum)
                                                   )
                                                )
                                             )
                                          );
   
   type FlussSeitenArray is array (KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Range) of Natural;
   FlüsseLinks : constant FlussSeitenArray := (
                                                KartenfluesseDatentypen.Fluss_Senkrecht_Enum          => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartenfluesseDatentypen.Flusskurve_Unten_Links_Enum   => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                KartenfluesseDatentypen.Flusskurve_Oben_Links_Enum    => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartenfluesseDatentypen.Flusskreuzung_Drei_Links_Enum => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Vier_Enum),
                                                KartenfluesseDatentypen.Flussende_Rechts_Enum     => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Fluss_Waagrecht_Enum),
                                                KartenfluesseDatentypen.Flussende_Unten_Enum      => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartenfluesseDatentypen.Flussende_Oben_Enum       => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Unten_Rechts_Enum),
                                                KartenfluesseDatentypen.See_Enum                      => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Links_Enum),
                                                others                                              => 0
                                               );
   
   FlüsseRechts : constant FlussSeitenArray := (
                                                 KartenfluesseDatentypen.Fluss_Senkrecht_Enum           => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                 KartenfluesseDatentypen.Flusskurve_Unten_Rechts_Enum   => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                                 KartenfluesseDatentypen.Flusskurve_Oben_Rechts_Enum    => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                 KartenfluesseDatentypen.Flusskreuzung_Drei_Rechts_Enum => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Vier_Enum),
                                                 KartenfluesseDatentypen.Flussende_Links_Enum       => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Fluss_Waagrecht_Enum),
                                                 KartenfluesseDatentypen.Flussende_Unten_Enum       => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Oben_Links_Enum),
                                                 KartenfluesseDatentypen.Flussende_Oben_Enum        => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Unten_Links_Enum),
                                                 KartenfluesseDatentypen.See_Enum                       => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Rechts_Enum),
                                                 others                                               => 0
                                                );
   
   FlüsseOben : constant FlussSeitenArray := (
                                               KartenfluesseDatentypen.Fluss_Waagrecht_Enum         => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Unten_Enum),
                                               KartenfluesseDatentypen.Flusskurve_Oben_Rechts_Enum  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                               KartenfluesseDatentypen.Flusskurve_Oben_Links_Enum   => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Links_Enum),
                                               KartenfluesseDatentypen.Flusskreuzung_Drei_Oben_Enum => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Vier_Enum),
                                               KartenfluesseDatentypen.Flussende_Links_Enum     => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Unten_Rechts_Enum),
                                               KartenfluesseDatentypen.Flussende_Rechts_Enum    => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Unten_Links_Enum),
                                               KartenfluesseDatentypen.Flussende_Unten_Enum     => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Fluss_Senkrecht_Enum),
                                               KartenfluesseDatentypen.See_Enum                     => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Oben_Enum),
                                               others                                             => 0
                                              );
   
   FlüsseUnten : constant FlussSeitenArray := (
                                                KartenfluesseDatentypen.Fluss_Waagrecht_Enum          => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Oben_Enum),
                                                KartenfluesseDatentypen.Flusskurve_Unten_Rechts_Enum  => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Rechts_Enum),
                                                KartenfluesseDatentypen.Flusskurve_Unten_Links_Enum   => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Drei_Links_Enum),
                                                KartenfluesseDatentypen.Flusskreuzung_Drei_Unten_Enum => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskreuzung_Vier_Enum),
                                                KartenfluesseDatentypen.Flussende_Links_Enum      => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Oben_Rechts_Enum),
                                                KartenfluesseDatentypen.Flussende_Rechts_Enum     => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flusskurve_Oben_Links_Enum),
                                                KartenfluesseDatentypen.Flussende_Oben_Enum       => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Fluss_Senkrecht_Enum),
                                                KartenfluesseDatentypen.See_Enum                      => KartenfluesseDatentypen.Fluss_Oberfläche_Enum'Pos (KartenfluesseDatentypen.Flussende_Unten_Enum),
                                                others                                              => 0
                                               );
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
end FlussplatzierungssystemLogik;
