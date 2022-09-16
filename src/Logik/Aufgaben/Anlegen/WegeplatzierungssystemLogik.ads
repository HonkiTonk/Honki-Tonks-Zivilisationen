pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;

private with KartenverbesserungDatentypen;

with Karten;

package WegeplatzierungssystemLogik is

   procedure Wegplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
private
   
   WegLinks : Boolean;
   WegRechts : Boolean;
   WegOben : Boolean;
   WegUnten : Boolean;
      
   WelcherWeg : KartenverbesserungDatentypen.Karten_Weg_Enum;
   ZwischenWeg : KartenverbesserungDatentypen.Karten_Weg_Enum;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   -- Teile davon auch nach Umwandlungen auslagern? äöü
   type StandardWegArray is array (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   StandardWeg : constant StandardWegArray := (
                                               KartenverbesserungDatentypen.Karten_Straße_Enum'Range  => AufgabenDatentypen.Straße_Bauen_Enum,
                                               KartenverbesserungDatentypen.Karten_Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                               KartenverbesserungDatentypen.Karten_Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                              );
   
   type WegtypArray is array (AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range) of Natural;
   Wegtyp : constant WegtypArray := (
                                     AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                     
                                     AufgabenDatentypen.Schiene_Bauen_Enum =>
                                       KartenverbesserungDatentypen.Karten_Schiene_Enum'Pos (KartenverbesserungDatentypen.Schienenkreuzung_Vier_Enum)
                                     - KartenverbesserungDatentypen.Karten_Straße_Enum'Pos (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                     
                                     AufgabenDatentypen.Tunnel_Bauen_Enum  =>
                                       KartenverbesserungDatentypen.Karten_Tunnel_Enum'Pos (KartenverbesserungDatentypen.Tunnelkreuzung_Vier_Enum)
                                     - KartenverbesserungDatentypen.Karten_Straße_Enum'Pos (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                    );
   
   type WegwertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Natural;
   Wegwert : constant WegwertArray := (
                                       True =>
                                         (
                                          True =>
                                            (
                                             True =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straße_Waagrecht_Enum)
                                               )
                                            ),
                                              
                                          False =>
                                            (
                                             True =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum)
                                               )
                                            )
                                         ),
                                           
                                       False =>
                                         (
                                          True =>
                                            (
                                             True =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenendstück_Links_Enum)
                                               )
                                            ),
                                              
                                          False =>
                                            (
                                             True =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straße_Senkrecht_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenendstück_Unten_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straßenendstück_Oben_Enum),
                                                False => KartenverbesserungDatentypen.Karten_Weg_Enum'Pos (KartenverbesserungDatentypen.Straße_Einzeln_Enum)
                                               )
                                            )
                                         )
                                      );
   
   type WegeSeitenArray is array (KartenverbesserungDatentypen.Karten_Straße_Enum'Range) of Natural;
   WegeLinks : constant WegeSeitenArray := (
                                            -- Alle Möglichkeiten die sich ändern.
                                            KartenverbesserungDatentypen.Straße_Senkrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straße_Waagrecht_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straße_Einzeln_Enum              => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenendstück_Links_Enum),
                                            
                                            -- Alle Möglichkeiten die gleich bleiben.
                                            KartenverbesserungDatentypen.Straße_Waagrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straße_Waagrecht_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Links_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenendstück_Links_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                           );
   
   WegeRechts : constant WegeSeitenArray := (
                                             -- Alle Möglichkeiten die sich ändern.
                                             KartenverbesserungDatentypen.Straße_Senkrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                             KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                             KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                             KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                             KartenverbesserungDatentypen.Straßenendstück_Links_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straße_Waagrecht_Enum),
                                             KartenverbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                             KartenverbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                             KartenverbesserungDatentypen.Straße_Einzeln_Enum              => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum),
                                             
                                             -- Alle Möglichkeiten die gleich bleiben.
                                             KartenverbesserungDatentypen.Straße_Waagrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straße_Waagrecht_Enum),
                                             KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                             KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                             KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum),
                                             KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                             KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                             KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                             KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                            );
   
   WegeOben : constant WegeSeitenArray := (
                                           -- Alle Möglichkeiten die sich ändern.
                                           KartenverbesserungDatentypen.Straße_Waagrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                           KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                           KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                           KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                           KartenverbesserungDatentypen.Straßenendstück_Links_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                           KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                           KartenverbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straße_Senkrecht_Enum),
                                           KartenverbesserungDatentypen.Straße_Einzeln_Enum              => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenendstück_Oben_Enum),
                                            
                                           -- Alle Möglichkeiten die gleich bleiben.
                                           KartenverbesserungDatentypen.Straße_Senkrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straße_Senkrecht_Enum),
                                           KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                           KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                           KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                           KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                           KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                           KartenverbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenendstück_Oben_Enum),
                                           KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                          );
   
   WegeUnten : constant WegeSeitenArray := (
                                            -- Alle Möglichkeiten die sich ändern.
                                            KartenverbesserungDatentypen.Straße_Waagrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Links_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straße_Senkrecht_Enum),
                                            KartenverbesserungDatentypen.Straße_Einzeln_Enum              => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenendstück_Unten_Enum),
                                            
                                            -- Alle Möglichkeiten die gleich bleiben.
                                            KartenverbesserungDatentypen.Straße_Senkrecht_Enum            => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straße_Senkrecht_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                            KartenverbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenendstück_Unten_Enum),
                                            KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                           );
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
end WegeplatzierungssystemLogik;