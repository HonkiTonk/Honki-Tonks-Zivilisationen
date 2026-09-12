with KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;

private with KartenwegeDatentypen;

with LeseWeltkarteneinstellungen;

package WegeplatzierungssystemLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   procedure Wegentfernung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Wegplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
         
   WelcherWeg : KartenwegeDatentypen.Weg_Enum;
   ZwischenWeg : KartenwegeDatentypen.Weg_Enum;
   EntfernungWeg : KartenwegeDatentypen.Weg_Enum;
   
   Entfernungskartenwert : KartenRecords.KartenfeldNaturalRecord;
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   Wegumgebung : KartenRecords.UmgebungskreuzRecord;
   
   type StandardWegArray is array (KartenwegeDatentypen.Weg_Vorhanden_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   StandardWeg : constant StandardWegArray := (
                                               KartenwegeDatentypen.Straße_Enum'Range  => AufgabenDatentypen.Straße_Bauen_Enum,
                                               KartenwegeDatentypen.Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                               KartenwegeDatentypen.Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                              );
   
   type WegtypArray is array (AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range) of Natural;
   Wegtyp : constant WegtypArray := (
                                     AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                     
                                     AufgabenDatentypen.Schiene_Bauen_Enum =>
                                       KartenwegeDatentypen.Schiene_Enum'Pos (KartenwegeDatentypen.Schienenkreuzung_Vier_Enum)
                                     - KartenwegeDatentypen.Straße_Enum'Pos (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum),
                                     
                                     AufgabenDatentypen.Tunnel_Bauen_Enum  =>
                                       KartenwegeDatentypen.Tunnel_Enum'Pos (KartenwegeDatentypen.Tunnelkreuzung_Vier_Enum)
                                     - KartenwegeDatentypen.Straße_Enum'Pos (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum)
                                    );
   
   type WegwertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Positive;
   Wegwert : constant WegwertArray := (
                                       True =>
                                         (
                                          True =>
                                            (
                                             True =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straße_Waagrecht_Enum)
                                               )
                                            ),
                                              
                                          False =>
                                            (
                                             True =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenende_Rechts_Enum)
                                               )
                                            )
                                         ),
                                           
                                       False =>
                                         (
                                          True =>
                                            (
                                             True =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenende_Links_Enum)
                                               )
                                            ),
                                              
                                          False =>
                                            (
                                             True =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straße_Senkrecht_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenende_Unten_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straßenende_Oben_Enum),
                                                False => KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Straße_Einzeln_Enum)
                                               )
                                            )
                                         )
                                      );
   
   type WegeSeitenArray is array (KartenwegeDatentypen.Straße_Enum'Range) of Positive;
   WegeLinks : constant WegeSeitenArray := (
                                            -- Alle Möglichkeiten die sich ändern.
                                            KartenwegeDatentypen.Straße_Senkrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum     => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenwegeDatentypen.Straßenende_Rechts_Enum      => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straße_Waagrecht_Enum),
                                            KartenwegeDatentypen.Straßenende_Unten_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenende_Oben_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                            KartenwegeDatentypen.Straße_Einzeln_Enum              => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenende_Links_Enum),
                                            
                                            -- Alle Möglichkeiten die gleich bleiben.
                                            KartenwegeDatentypen.Straße_Waagrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straße_Waagrecht_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenende_Links_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenende_Links_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Vier_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum)
                                           );
   
   WegeRechts : constant WegeSeitenArray := (
                                             -- Alle Möglichkeiten die sich ändern.
                                             KartenwegeDatentypen.Straße_Senkrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                             KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                             KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                             KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum),
                                             KartenwegeDatentypen.Straßenende_Links_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straße_Waagrecht_Enum),
                                             KartenwegeDatentypen.Straßenende_Unten_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum),
                                             KartenwegeDatentypen.Straßenende_Oben_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum),
                                             KartenwegeDatentypen.Straße_Einzeln_Enum              => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenende_Rechts_Enum),
                                             
                                             -- Alle Möglichkeiten die gleich bleiben.
                                             KartenwegeDatentypen.Straße_Waagrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straße_Waagrecht_Enum),
                                             KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum),
                                             KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                             KartenwegeDatentypen.Straßenende_Rechts_Enum      => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenende_Rechts_Enum),
                                             KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum     => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum),
                                             KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                             KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                             KartenwegeDatentypen.Straßenkreuzung_Vier_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                               (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum)
                                            );
   
   WegeOben : constant WegeSeitenArray := (
                                           -- Alle Möglichkeiten die sich ändern.
                                           KartenwegeDatentypen.Straße_Waagrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                           KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                           KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum     => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                           KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum),
                                           KartenwegeDatentypen.Straßenende_Links_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                           KartenwegeDatentypen.Straßenende_Rechts_Enum      => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum),
                                           KartenwegeDatentypen.Straßenende_Unten_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straße_Senkrecht_Enum),
                                           KartenwegeDatentypen.Straße_Einzeln_Enum              => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenende_Oben_Enum),
                                            
                                           -- Alle Möglichkeiten die gleich bleiben.
                                           KartenwegeDatentypen.Straße_Senkrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straße_Senkrecht_Enum),
                                           KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                           KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum),
                                           KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                           KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                           KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                           KartenwegeDatentypen.Straßenende_Oben_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenende_Oben_Enum),
                                           KartenwegeDatentypen.Straßenkreuzung_Vier_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                             (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum)
                                          );
   
   WegeUnten : constant WegeSeitenArray := (
                                            -- Alle Möglichkeiten die sich ändern.
                                            KartenwegeDatentypen.Straße_Waagrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Unten_Links_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenwegeDatentypen.Straßenende_Links_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenende_Rechts_Enum      => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum),
                                            KartenwegeDatentypen.Straßenende_Oben_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straße_Senkrecht_Enum),
                                            KartenwegeDatentypen.Straße_Einzeln_Enum              => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenende_Unten_Enum),
                                            
                                            -- Alle Möglichkeiten die gleich bleiben.
                                            KartenwegeDatentypen.Straße_Senkrecht_Enum            => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straße_Senkrecht_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum     => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkurve_Oben_Links_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                            KartenwegeDatentypen.Straßenende_Unten_Enum       => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenende_Unten_Enum),
                                            KartenwegeDatentypen.Straßenkreuzung_Vier_Enum        => KartenwegeDatentypen.Weg_Vorhanden_Enum'Pos
                                              (KartenwegeDatentypen.Straßenkreuzung_Vier_Enum)
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
   
   function BerechnungOben
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
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
end WegeplatzierungssystemLogik;
