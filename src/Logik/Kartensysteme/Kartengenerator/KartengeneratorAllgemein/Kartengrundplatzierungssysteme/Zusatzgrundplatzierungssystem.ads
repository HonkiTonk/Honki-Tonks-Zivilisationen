with KartenRecords;
with KartengrundDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package Zusatzgrundplatzierungssystem is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

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

   Grundnummer : Positive;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   type ZusatzgrundVorhandenRecord is record

      Links : Boolean;
      Rechts : Boolean;
      Oben : Boolean;
      Unten : Boolean;

   end record;

   ZusatzgrundVorhanden : ZusatzgrundVorhandenRecord;

   type GrundZuNummerArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of Positive;
   GrundZuNummer : constant GrundZuNummerArray := (
                                                   KartengrundDatentypen.Zusatzgrund_Wald_Enum'Range      => 1,
                                                   KartengrundDatentypen.Zusatzgrund_Dschungel_Enum'Range => 2,
                                                   KartengrundDatentypen.Zusatzgrund_Sumpf_Enum'Range     => 3,

                                                   KartengrundDatentypen.Zusatzgrund_Korallen_Enum'Range  => 4,
                                                   KartengrundDatentypen.Zusatzgrund_Unterwald_Enum'Range => 5
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
