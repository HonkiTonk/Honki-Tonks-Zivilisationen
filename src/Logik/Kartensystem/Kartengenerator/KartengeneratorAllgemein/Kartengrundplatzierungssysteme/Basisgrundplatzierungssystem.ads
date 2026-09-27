with KartenRecords;
with KartenDatentypen;
with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;

package Basisgrundplatzierungssystem is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   procedure Basisgrundplatzierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   WelcherGrund : KartenbasisgrundDatentypen.Basisgrund_Enum;

   Grundnummer : Positive;
   AndersfeldigeGrundnummer : Positive;

   Kartenwert : KartenRecords.KartenfeldNaturalRecord;

   Grundumgebung : KartenRecords.UmgebungskreuzRecord;

   -- Das hier später anpassen, wenn ich tatsächliche alle Basisgründe so erweitere. äöü
   type GrundZuNummerArray is array (KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Positive;
   GrundZuNummer : constant GrundZuNummerArray := (
                                                   -- KartenbasisgrundDatentypen.Basisgrund_Flachland_Enum'Range => 1,
                                                   -- KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range     => 2,
                                                   -- KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum'Range    => 3,
                                                   KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range     => 1,
                                                   KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range   => 2,

                                                   others => 1_000
                                                  );

   type BasisgrundtypArray is array (1 .. 2) of Natural;
   Basisgrundtyp : constant BasisgrundtypArray := (
                                                   1 => 0,
                                                   2 =>
                                                     KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Pos (KartenbasisgrundDatentypen.Gebirgekreuzung_Vier_Enum)
                                                   - KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                  );

   type BasisgrundwertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Positive;
   Basisgrundwert : constant BasisgrundwertArray := (
                                                     True =>
                                                       (
                                                        True =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum)
                                                             )
                                                          ),

                                                        False =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Rechts_Enum)
                                                             )
                                                          )
                                                       ),

                                                     False =>
                                                       (
                                                        True =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Links_Enum)
                                                             )
                                                          ),

                                                        False =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Unten_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Oben_Enum),
                                                              False => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Enum)
                                                             )
                                                          )
                                                       )
                                                    );

   type BasisgrundSeitenArray is array (KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range) of Positive;
   BasisgrundLinks : constant BasisgrundSeitenArray := (
                                                        -- Alle Möglichkeiten die sich ändern.
                                                        KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Unten_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Oben_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügel_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Links_Enum),

                                                        -- Alle Möglichkeiten die gleich bleiben.
                                                        KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Links_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                       );

   BasisgrundRechts : constant BasisgrundSeitenArray := (
                                                         -- Alle Möglichkeiten die sich ändern.
                                                         KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                         KartenbasisgrundDatentypen.Hügelende_Links_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum),
                                                         KartenbasisgrundDatentypen.Hügelende_Unten_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                         KartenbasisgrundDatentypen.Hügelende_Oben_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                         KartenbasisgrundDatentypen.Hügel_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Rechts_Enum),

                                                         -- Alle Möglichkeiten die gleich bleiben.
                                                         KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                         KartenbasisgrundDatentypen.Hügelende_Rechts_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Rechts_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                         KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum
                                                         => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                        );

   BasisgrundOben : constant BasisgrundSeitenArray := (
                                                       -- Alle Möglichkeiten die sich ändern.
                                                       KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                       KartenbasisgrundDatentypen.Hügelende_Links_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                       KartenbasisgrundDatentypen.Hügelende_Rechts_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                       KartenbasisgrundDatentypen.Hügelende_Unten_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum),
                                                       KartenbasisgrundDatentypen.Hügel_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Oben_Enum),

                                                       -- Alle Möglichkeiten die gleich bleiben.
                                                       KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                       KartenbasisgrundDatentypen.Hügelende_Oben_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Oben_Enum),
                                                       KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum
                                                       => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                      );

   BasisgrundUnten : constant BasisgrundSeitenArray := (
                                                        -- Alle Möglichkeiten die sich ändern.
                                                        KartenbasisgrundDatentypen.Hügel_Waagrecht_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Unten_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Unten_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Unten_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Oben_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum),
                                                        KartenbasisgrundDatentypen.Hügel_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Unten_Enum),

                                                        -- Alle Möglichkeiten die gleich bleiben.
                                                        KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügel_Senkrecht_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                        KartenbasisgrundDatentypen.Hügelende_Unten_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelende_Unten_Enum),
                                                        KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum
                                                        => KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartenbasisgrundDatentypen.Hügelkreuzung_Vier_Enum)
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

end Basisgrundplatzierungssystem;
