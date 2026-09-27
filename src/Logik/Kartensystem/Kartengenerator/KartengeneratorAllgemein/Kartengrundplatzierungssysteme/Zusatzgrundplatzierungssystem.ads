with KartenRecords;
with KartenzusatzgrundDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package Zusatzgrundplatzierungssystem is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure Zusatzgrundentfernung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Zusatzgrundplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ZusatzgrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   WelcherGrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   AktuellerGrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   NebenfeldGrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;

   Grundnummer : Positive;
   AndersfeldigeGrundnummer : Positive;

   Kartenwert : KartenRecords.KartenfeldNaturalRecord;
   Entfernungskartenwert : KartenRecords.KartenfeldNaturalRecord;

   Grundumgebung : KartenRecords.UmgebungskreuzRecord;

   type GrundZuNummerArray is array (KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of Positive;
   GrundZuNummer : constant GrundZuNummerArray := (
                                                   KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range      => 1,
                                                   KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum'Range => 2,
                                                   KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum'Range     => 3,

                                                   KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum'Range  => 4,
                                                   KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum'Range => 5
                                                  );

   type ZusatzgrundtypArray is array (GrundZuNummer (GrundZuNummer'First) .. GrundZuNummer (GrundZuNummer'Last)) of Natural;
   Zusatzgrundtyp : constant ZusatzgrundtypArray := (
                                                     1 => 0,
                                                     2 =>
                                                       KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum'Pos (KartenzusatzgrundDatentypen.Dschungelkreuzung_Vier_Enum)
                                                     - KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                     3 =>
                                                       KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum'Pos (KartenzusatzgrundDatentypen.Sumpfkreuzung_Vier_Enum)
                                                     - KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                     4 =>
                                                       KartenzusatzgrundDatentypen.Zusatzgrund_Korallen_Enum'Pos (KartenzusatzgrundDatentypen.Korallenkreuzung_Vier_Enum)
                                                     - KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                     5 =>
                                                       KartenzusatzgrundDatentypen.Zusatzgrund_Unterwald_Enum'Pos (KartenzusatzgrundDatentypen.Unterwaldkreuzung_Vier_Enum)
                                                     - KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum)
                                                    );

   type ZusatzgrundwertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Positive;
   Zusatzgrundwert : constant ZusatzgrundwertArray := (
                                                       True =>
                                                         (
                                                          True =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum)
                                                               )
                                                            ),

                                                          False =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Rechts_Enum)
                                                               )
                                                            )
                                                         ),

                                                       False =>
                                                         (
                                                          True =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Links_Enum)
                                                               )
                                                            ),

                                                          False =>
                                                            (
                                                             True =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Unten_Enum)
                                                               ),

                                                             False =>
                                                               (
                                                                True  => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Oben_Enum),
                                                                False => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Enum)
                                                               )
                                                            )
                                                         )
                                                      );

   type ZusatzgrundSeitenArray is array (KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range) of Positive;
   ZusatzgrundLinks : constant ZusatzgrundSeitenArray := (
                                                          -- Alle Möglichkeiten die sich ändern.
                                                          KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Unten_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Oben_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Wald_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Links_Enum),

                                                          -- Alle Möglichkeiten die gleich bleiben.
                                                          KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Links_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum)
                                                         );

   ZusatzgrundRechts : constant ZusatzgrundSeitenArray := (
                                                           -- Alle Möglichkeiten die sich ändern.
                                                           KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                           KartenzusatzgrundDatentypen.Waldende_Links_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum),
                                                           KartenzusatzgrundDatentypen.Waldende_Unten_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                           KartenzusatzgrundDatentypen.Waldende_Oben_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                           KartenzusatzgrundDatentypen.Wald_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Rechts_Enum),

                                                           -- Alle Möglichkeiten die gleich bleiben.
                                                           KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                           KartenzusatzgrundDatentypen.Waldende_Rechts_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Rechts_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                           KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum
                                                           => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum)
                                                          );

   ZusatzgrundOben : constant ZusatzgrundSeitenArray := (
                                                         -- Alle Möglichkeiten die sich ändern.
                                                         KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                         KartenzusatzgrundDatentypen.Waldende_Links_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                         KartenzusatzgrundDatentypen.Waldende_Rechts_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                         KartenzusatzgrundDatentypen.Waldende_Unten_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum),
                                                         KartenzusatzgrundDatentypen.Wald_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Oben_Enum),

                                                         -- Alle Möglichkeiten die gleich bleiben.
                                                         KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                         KartenzusatzgrundDatentypen.Waldende_Oben_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Oben_Enum),
                                                         KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum
                                                         => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum)
                                                        );

   ZusatzgrundUnten : constant ZusatzgrundSeitenArray := (
                                                          -- Alle Möglichkeiten die sich ändern.
                                                          KartenzusatzgrundDatentypen.Wald_Waagrecht_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Unten_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Unten_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Unten_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Oben_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum),
                                                          KartenzusatzgrundDatentypen.Wald_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Unten_Enum),

                                                          -- Alle Möglichkeiten die gleich bleiben.
                                                          KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Wald_Senkrecht_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkurve_Oben_Links_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Oben_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Rechts_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Drei_Links_Enum),
                                                          KartenzusatzgrundDatentypen.Waldende_Unten_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldende_Unten_Enum),
                                                          KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum
                                                          => KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Pos (KartenzusatzgrundDatentypen.Waldkreuzung_Vier_Enum)
                                                         );



   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end Zusatzgrundplatzierungssystem;
