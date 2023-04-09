with KartenRecords;
with KartengrundDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package Zusatzgrundplatzierungssystem is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure Zusatzgrundentfernung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Zusatzgrundplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

private

   WelcherGrund : KartengrundDatentypen.Zusatzgrund_Enum;
   AktuellerGrund : KartengrundDatentypen.Zusatzgrund_Enum;
   NebenfeldGrund : KartengrundDatentypen.Zusatzgrund_Enum;

   Grundnummer : Positive;
   AndersfeldigeGrundnummer : Positive;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Entfernungskartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   Grundumgebung : KartenRecords.UmgebungskreuzRecord;

   type GrundZuNummerArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of Positive;
   GrundZuNummer : constant GrundZuNummerArray := (
                                                   KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range      => 1,
                                                   KartengrundDatentypen.Zusatzgrund_Dschungel_Enum'Range => 2,
                                                   KartengrundDatentypen.Zusatzgrund_Sumpf_Enum'Range     => 3,

                                                   KartengrundDatentypen.Zusatzgrund_Korallen_Enum'Range  => 4,
                                                   KartengrundDatentypen.Zusatzgrund_Unterwald_Enum'Range => 5
                                                  );

   type ZusatzgrundtypArray is array (GrundZuNummer (GrundZuNummer'First) .. GrundZuNummer (GrundZuNummer'Last)) of Natural;
   Zusatzgrundtyp : constant ZusatzgrundtypArray := (
                                                     1 => 0,
                                                     2 =>
                                                       KartengrundDatentypen.Zusatzgrund_Dschungel_Enum'Pos (KartengrundDatentypen.Dschungelkreuzung_Vier_Enum)
                                                     - KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                     3 =>
                                                       KartengrundDatentypen.Zusatzgrund_Sumpf_Enum'Pos (KartengrundDatentypen.Sumpfkreuzung_Vier_Enum)
                                                     - KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                     4 =>
                                                       KartengrundDatentypen.Zusatzgrund_Korallen_Enum'Pos (KartengrundDatentypen.Korallenkreuzung_Vier_Enum)
                                                     - KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                     5 =>
                                                       KartengrundDatentypen.Zusatzgrund_Unterwald_Enum'Pos (KartengrundDatentypen.Unterwaldkreuzung_Vier_Enum)
                                                     - KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum)
                                                    );

   type ZusatzgrundwertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Positive;
   Zusatzgrundwert : constant ZusatzgrundwertArray := (
                                                       True =>
                                                         (
                                                          True =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Waagrecht_Enum)
                                                               )
                                                            ),

                                                          False =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Links_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Rechts_Enum)
                                                               )
                                                            )
                                                         ),

                                                       False =>
                                                         (
                                                          True =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Links_Enum)
                                                               )
                                                            ),

                                                          False =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Senkrecht_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Unten_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Oben_Enum),
                                                                False => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Enum)
                                                               )
                                                            )
                                                         )
                                                      );

   type ZusatzgrundSeitenArray is array (KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range) of Positive;
   ZusatzgrundLinks : constant ZusatzgrundSeitenArray := (
                                                          -- Alle Möglichkeiten die sich ändern.
                                                          KartengrundDatentypen.Wald_Senkrecht_Enum           => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartengrundDatentypen.Waldkurve_Unten_Links_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                          KartengrundDatentypen.Waldkurve_Oben_Links_Enum     => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                          KartengrundDatentypen.Waldendstück_Rechts_Enum      => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Waagrecht_Enum),
                                                          KartengrundDatentypen.Waldendstück_Unten_Enum       => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartengrundDatentypen.Waldendstück_Oben_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                          KartengrundDatentypen.Wald_Enum                     => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Links_Enum),

                                                          -- Alle Möglichkeiten die gleich bleiben.
                                                          KartengrundDatentypen.Wald_Waagrecht_Enum           => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Waagrecht_Enum),
                                                          KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                          KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartengrundDatentypen.Waldendstück_Links_Enum       => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Links_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Vier_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum)
                                                         );

   ZusatzgrundRechts : constant ZusatzgrundSeitenArray := (
                                                           -- Alle Möglichkeiten die sich ändern.
                                                           KartengrundDatentypen.Wald_Senkrecht_Enum           => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                           KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                           KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                           KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                           KartengrundDatentypen.Waldendstück_Links_Enum       => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Waagrecht_Enum),
                                                           KartengrundDatentypen.Waldendstück_Unten_Enum       => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                           KartengrundDatentypen.Waldendstück_Oben_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                           KartengrundDatentypen.Wald_Enum                     => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Rechts_Enum),

                                                           -- Alle Möglichkeiten die gleich bleiben.
                                                           KartengrundDatentypen.Wald_Waagrecht_Enum           => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Waagrecht_Enum),
                                                           KartengrundDatentypen.Waldkurve_Unten_Links_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                           KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                           KartengrundDatentypen.Waldendstück_Rechts_Enum      => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Rechts_Enum),
                                                           KartengrundDatentypen.Waldkurve_Oben_Links_Enum     => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                           KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                           KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                           KartengrundDatentypen.Waldkreuzung_Vier_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum)
                                                          );

   ZusatzgrundOben : constant ZusatzgrundSeitenArray := (
                                                         -- Alle Möglichkeiten die sich ändern.
                                                         KartengrundDatentypen.Wald_Waagrecht_Enum          => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                         KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                         KartengrundDatentypen.Waldkurve_Oben_Links_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                         KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                         KartengrundDatentypen.Waldendstück_Links_Enum      => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                         KartengrundDatentypen.Waldendstück_Rechts_Enum     => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                         KartengrundDatentypen.Waldendstück_Unten_Enum      => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Senkrecht_Enum),
                                                         KartengrundDatentypen.Wald_Enum                    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Oben_Enum),

                                                         -- Alle Möglichkeiten die gleich bleiben.
                                                         KartengrundDatentypen.Wald_Senkrecht_Enum           => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Senkrecht_Enum),
                                                         KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                         KartengrundDatentypen.Waldkurve_Unten_Links_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                         KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                         KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                         KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                         KartengrundDatentypen.Waldendstück_Oben_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Oben_Enum),
                                                         KartengrundDatentypen.Waldkreuzung_Vier_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum)
                                                        );

   ZusatzgrundUnten : constant ZusatzgrundSeitenArray := (
                                                          -- Alle Möglichkeiten die sich ändern.
                                                          KartengrundDatentypen.Wald_Waagrecht_Enum           => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartengrundDatentypen.Waldkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartengrundDatentypen.Waldkurve_Unten_Links_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum),
                                                          KartengrundDatentypen.Waldendstück_Links_Enum       => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartengrundDatentypen.Waldendstück_Rechts_Enum      => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                          KartengrundDatentypen.Waldendstück_Oben_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Senkrecht_Enum),
                                                          KartengrundDatentypen.Wald_Enum                     => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Unten_Enum),

                                                          -- Alle Möglichkeiten die gleich bleiben.
                                                          KartengrundDatentypen.Wald_Senkrecht_Enum           => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Wald_Senkrecht_Enum),
                                                          KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum    => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartengrundDatentypen.Waldkurve_Oben_Links_Enum     => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum   => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                          KartengrundDatentypen.Waldendstück_Unten_Enum       => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldendstück_Unten_Enum),
                                                          KartengrundDatentypen.Waldkreuzung_Vier_Enum        => KartengrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartengrundDatentypen.Waldkreuzung_Vier_Enum)
                                                         );



   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end Zusatzgrundplatzierungssystem;
