pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with KartenVerbesserungDatentypen;
with AufgabenDatentypen;

with Karten;

package Wegeplatzierungssystem is

   procedure WegBerechnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
private
   
   WegLinks : Boolean;
   WegRechts : Boolean;
   WegOben : Boolean;
   WegUnten : Boolean;
   
   Weggruppe : Positive;
   
   WelcherWeg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   ZwischenWeg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type StandardWegArray is array (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   StandardWeg : constant StandardWegArray := (
                                               KartenVerbesserungDatentypen.Karten_Straße_Enum'Range  => AufgabenDatentypen.Straße_Bauen_Enum,
                                               KartenVerbesserungDatentypen.Karten_Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                               KartenVerbesserungDatentypen.Karten_Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                              );
   
   type WegtypArray is array (AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range) of Natural;
   Wegtyp : constant WegtypArray := (
                                     AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                     
                                     AufgabenDatentypen.Schiene_Bauen_Enum =>
                                       KartenVerbesserungDatentypen.Karten_Schiene_Enum'Pos (KartenVerbesserungDatentypen.Schienenkreuzung_Vier_Enum)
                                     - KartenVerbesserungDatentypen.Karten_Straße_Enum'Pos (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                     
                                     AufgabenDatentypen.Tunnel_Bauen_Enum  =>
                                       KartenVerbesserungDatentypen.Karten_Tunnel_Enum'Pos (KartenVerbesserungDatentypen.Tunnelkreuzung_Vier_Enum)
                                     - KartenVerbesserungDatentypen.Karten_Straße_Enum'Pos (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                    );
   
   type WegwertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Natural;
   Wegwert : constant WegwertArray := (
                                       True =>
                                         (
                                          True =>
                                            (
                                             True =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straße_Waagrecht_Enum)
                                               )
                                            ),
                                              
                                          False =>
                                            (
                                             True =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum)
                                               )
                                            )
                                         ),
                                           
                                       False =>
                                         (
                                          True =>
                                            (
                                             True =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenendstück_Links_Enum)
                                               )
                                            ),
                                              
                                          False =>
                                            (
                                             True =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straße_Senkrecht_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum)
                                               ),
                                                 
                                             False =>
                                               (
                                                True  => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum),
                                                False => KartenVerbesserungDatentypen.Karten_Weg_Enum'Pos (KartenVerbesserungDatentypen.Straße_Einzeln_Enum)
                                               )
                                            )
                                         )
                                      );
   
   type WegeSeitenArray is array (KartenVerbesserungDatentypen.Karten_Straße_Enum'Range) of Natural;
   WegeLinks : constant WegeSeitenArray := (
                                            -- Alle Möglichkeiten die sich ändern.
                                            KartenVerbesserungDatentypen.Straße_Senkrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straße_Waagrecht_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straße_Einzeln_Enum              => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenendstück_Links_Enum),
                                            
                                            -- Alle Möglichkeiten die gleich bleiben.
                                            KartenVerbesserungDatentypen.Straße_Waagrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straße_Waagrecht_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Links_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenendstück_Links_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                           );
   
   WegeRechts : constant WegeSeitenArray := (
                                             -- Alle Möglichkeiten die sich ändern.
                                             KartenVerbesserungDatentypen.Straße_Senkrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                             KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                             KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                             KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                             KartenVerbesserungDatentypen.Straßenendstück_Links_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straße_Waagrecht_Enum),
                                             KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                             KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                             KartenVerbesserungDatentypen.Straße_Einzeln_Enum              => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum),
                                             
                                             -- Alle Möglichkeiten die gleich bleiben.
                                             KartenVerbesserungDatentypen.Straße_Waagrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straße_Waagrecht_Enum),
                                             KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                             KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                             KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum),
                                             KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                             KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                             KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                             KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                               (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                            );
   
   WegeOben : constant WegeSeitenArray := (
                                           -- Alle Möglichkeiten die sich ändern.
                                           KartenVerbesserungDatentypen.Straße_Waagrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                           KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                           KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                           KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                           KartenVerbesserungDatentypen.Straßenendstück_Links_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                           KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                           KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straße_Senkrecht_Enum),
                                           KartenVerbesserungDatentypen.Straße_Einzeln_Enum              => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum),
                                            
                                           -- Alle Möglichkeiten die gleich bleiben.
                                           KartenVerbesserungDatentypen.Straße_Senkrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straße_Senkrecht_Enum),
                                           KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                           KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                           KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                           KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                           KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                           KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum),
                                           KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                          );
   
   WegeUnten : constant WegeSeitenArray := (
                                            -- Alle Möglichkeiten die sich ändern.
                                            KartenVerbesserungDatentypen.Straße_Waagrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Links_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum      => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straße_Senkrecht_Enum),
                                            KartenVerbesserungDatentypen.Straße_Einzeln_Enum              => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum),
                                            
                                            -- Alle Möglichkeiten die gleich bleiben.
                                            KartenVerbesserungDatentypen.Straße_Senkrecht_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straße_Senkrecht_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum        => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum)
                                           );
   
   procedure WegPlatzieren
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
end Wegeplatzierungssystem;
