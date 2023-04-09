with KartenRecords;
with KartengrundDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package Basisgrundplatzierungssystem is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure Basisgrundplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

private

   WelcherGrund : KartengrundDatentypen.Basisgrund_Enum;

   Grundnummer : Positive;
   AndersfeldigeGrundnummer : Positive;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   Grundumgebung : KartenRecords.UmgebungskreuzRecord;

   -- Das hier später anpassen, wenn ich tatsächliche alle Basisgründe so erweitere. äöü
   type GrundZuNummerArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Positive;
   GrundZuNummer : constant GrundZuNummerArray := (
                                                   -- KartengrundDatentypen.Basisgrund_Flachland_Enum'Range => 1,
                                                   -- KartengrundDatentypen.Basisgrund_Wüste_Enum'Range     => 2,
                                                   -- KartengrundDatentypen.Basisgrund_Tundra_Enum'Range    => 3,
                                                   KartengrundDatentypen.Basisgrund_Hügel_Enum'Range     => 1,
                                                   KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range   => 2,

                                                   others => 1_000
                                                  );

   type BasisgrundtypArray is array (1 .. 2) of Natural;
   Basisgrundtyp : constant BasisgrundtypArray := (
                                                   1 => 0,
                                                   2 =>
                                                     KartengrundDatentypen.Basisgrund_Gebirge_Enum'Pos (KartengrundDatentypen.Gebirgekreuzung_Vier_Enum)
                                                   - KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                  );

   type BasisgrundwertArray is array (Boolean'Range, Boolean'Range, Boolean'Range, Boolean'Range) of Positive;
   Basisgrundwert : constant BasisgrundwertArray := (
                                                     True =>
                                                       (
                                                        True =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Waagrecht_Enum)
                                                             )
                                                          ),

                                                        False =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Links_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Rechts_Enum)
                                                             )
                                                          )
                                                       ),

                                                     False =>
                                                       (
                                                        True =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Links_Enum)
                                                             )
                                                          ),

                                                        False =>
                                                          (
                                                           True =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Senkrecht_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Unten_Enum)
                                                             ),

                                                           False =>
                                                             (
                                                              True  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Oben_Enum),
                                                              False => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Enum)
                                                             )
                                                          )
                                                       )
                                                    );

   type BasisgrundSeitenArray is array (KartengrundDatentypen.Basisgrund_Hügel_Enum'Range) of Positive;
   BasisgrundLinks : constant BasisgrundSeitenArray := (
                                                        -- Alle Möglichkeiten die sich ändern.
                                                        KartengrundDatentypen.Hügel_Senkrecht_Enum           => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Unten_Links_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Oben_Links_Enum     => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Rechts_Enum      => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Waagrecht_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Unten_Enum       => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Oben_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                        KartengrundDatentypen.Hügel_Enum                     => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Links_Enum),

                                                        -- Alle Möglichkeiten die gleich bleiben.
                                                        KartengrundDatentypen.Hügel_Waagrecht_Enum           => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Waagrecht_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Links_Enum       => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Links_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Vier_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                       );

   BasisgrundRechts : constant BasisgrundSeitenArray := (
                                                         -- Alle Möglichkeiten die sich ändern.
                                                         KartengrundDatentypen.Hügel_Senkrecht_Enum           => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                         KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                         KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                         KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                         KartengrundDatentypen.Hügelendstück_Links_Enum       => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Waagrecht_Enum),
                                                         KartengrundDatentypen.Hügelendstück_Unten_Enum       => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                         KartengrundDatentypen.Hügelendstück_Oben_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                         KartengrundDatentypen.Hügel_Enum                     => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Rechts_Enum),

                                                         -- Alle Möglichkeiten die gleich bleiben.
                                                         KartengrundDatentypen.Hügel_Waagrecht_Enum           => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Waagrecht_Enum),
                                                         KartengrundDatentypen.Hügelkurve_Unten_Links_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                         KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                         KartengrundDatentypen.Hügelendstück_Rechts_Enum      => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Rechts_Enum),
                                                         KartengrundDatentypen.Hügelkurve_Oben_Links_Enum     => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                         KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                         KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                         KartengrundDatentypen.Hügelkreuzung_Vier_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                        );

   BasisgrundOben : constant BasisgrundSeitenArray := (
                                                       -- Alle Möglichkeiten die sich ändern.
                                                       KartengrundDatentypen.Hügel_Waagrecht_Enum          => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                       KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                       KartengrundDatentypen.Hügelkurve_Oben_Links_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                       KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                       KartengrundDatentypen.Hügelendstück_Links_Enum      => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                       KartengrundDatentypen.Hügelendstück_Rechts_Enum     => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                       KartengrundDatentypen.Hügelendstück_Unten_Enum      => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Senkrecht_Enum),
                                                       KartengrundDatentypen.Hügel_Enum                    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Oben_Enum),

                                                       -- Alle Möglichkeiten die gleich bleiben.
                                                       KartengrundDatentypen.Hügel_Senkrecht_Enum           => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Senkrecht_Enum),
                                                       KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum),
                                                       KartengrundDatentypen.Hügelkurve_Unten_Links_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Unten_Links_Enum),
                                                       KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum),
                                                       KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                       KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                       KartengrundDatentypen.Hügelendstück_Oben_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Oben_Enum),
                                                       KartengrundDatentypen.Hügelkreuzung_Vier_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum)
                                                      );

   BasisgrundUnten : constant BasisgrundSeitenArray := (
                                                        -- Alle Möglichkeiten die sich ändern.
                                                        KartengrundDatentypen.Hügel_Waagrecht_Enum           => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Unten_Rechts_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Unten_Links_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Unten_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Links_Enum       => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Rechts_Enum      => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Oben_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Senkrecht_Enum),
                                                        KartengrundDatentypen.Hügel_Enum                     => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Unten_Enum),

                                                        -- Alle Möglichkeiten die gleich bleiben.
                                                        KartengrundDatentypen.Hügel_Senkrecht_Enum           => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügel_Senkrecht_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum    => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelkurve_Oben_Links_Enum     => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkurve_Oben_Links_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum   => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Oben_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Rechts_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum  => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Drei_Links_Enum),
                                                        KartengrundDatentypen.Hügelendstück_Unten_Enum       => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelendstück_Unten_Enum),
                                                        KartengrundDatentypen.Hügelkreuzung_Vier_Enum        => KartengrundDatentypen.Basisgrund_Hügel_Enum'Pos (KartengrundDatentypen.Hügelkreuzung_Vier_Enum)
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

end Basisgrundplatzierungssystem;
