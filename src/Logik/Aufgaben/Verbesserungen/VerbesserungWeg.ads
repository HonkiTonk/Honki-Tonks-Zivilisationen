pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenVerbesserungDatentypen;
with EinheitStadtRecords;
with SonstigeVariablen;
with KartenRecords;
with KartengrundDatentypen;
with SpielVariablen;

with Karten;

package VerbesserungWeg is

   procedure WegBerechnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   

   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   WegLinks : Boolean;
   WegRechts : Boolean;
   WegOben : Boolean;
   WegUnten : Boolean;
   
   WelcherWeg : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
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
   
   type WegeSeitenArray is array (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum) of Natural;
   WegeLinks : constant WegeSeitenArray := (
                                            KartenVerbesserungDatentypen.Straße_Senkrecht_Enum           => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straße_Waagrecht_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum      => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straße_Einzeln_Enum             => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenendstück_Links_Enum),
                                            others => 0
                                           );
   
   WegeRechts : constant WegeSeitenArray := (
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
                                             others => 0
                                            );
   
   WegeOben : constant WegeSeitenArray := (
                                           KartenVerbesserungDatentypen.Straße_Waagrecht_Enum          => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum),
                                           KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                           KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                           KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                           KartenVerbesserungDatentypen.Straßenendstück_Links_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum),
                                           KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum    => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum),
                                           KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straße_Senkrecht_Enum),
                                           KartenVerbesserungDatentypen.Straße_Einzeln_Enum            => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                             (KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum),
                                           others => 0
                                          );
   
   WegeUnten : constant WegeSeitenArray := (
                                            KartenVerbesserungDatentypen.Straße_Waagrecht_Enum           => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum  => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum   => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum),
                                            KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Links_Enum      => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum     => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum),
                                            KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum       => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straße_Senkrecht_Enum),
                                            KartenVerbesserungDatentypen.Straße_Einzeln_Enum             => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos
                                              (KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum),
                                            others => 0
                                           );
   
   
   procedure WegPlatzieren
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BerechnungUnten;
   procedure BerechnungOben;
   procedure BerechnungRechts;
   procedure BerechnungLinks;

end VerbesserungWeg;
