with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenRecords;
with KartenDatentypen;
with SpeziesDatentypen;

private with SpeziesArrays;
private with SystemKonstanten;

with LeseWeltkarteneinstellungen;

package LadenSichtbarkeitLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   procedure Leersetzung;
   
   procedure KoordinatenSetzen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FelderanzahlExtern : in Positive);
   
   
   
   function Aufteilung
     (DateiLadenExtern : in File_Type;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function AufteilungSpezienzusammenfassung
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernBasis;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 if
                   LadenPrüfenExtern
                     then
                 (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                  and
                    KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte)
              );
   
private
   
   Sichtbarkeit : Boolean;
   
   AktuellerArraybereich : SystemDatentypenHTSEB.EigenesPositive;
   
   Potenz : SystemDatentypenHTSEB.EigenerInteger;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernBasis;
   
   SichtbarkeitVorhanden : SystemDatentypenHTSEB.EinByte;
   
   SichtbarkeitVorhandenZweiByte : SystemDatentypenHTSEB.ZweiByte;
   
   SichtbarkeitVorhandenVorzeichen : SpeziesArrays.SoeziesSichtbarkeitVorzeichenArray;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   type KoordinatenArray is array (SystemDatentypenHTSEB.AchtElemente'Range) of KartenRecords.KartenfeldNaturalRecord;
   Koordinaten : KoordinatenArray;
   
   type SichtbarkeitGleichArray is array (SystemKonstanten.AllesUnsichtbar .. SystemKonstanten.AllesSichtbar) of Boolean;
   SichtbarkeitGleich : constant SichtbarkeitGleichArray := (
                                                             SystemKonstanten.AllesUnsichtbar => False,
                                                             SystemKonstanten.AllesSichtbar   => True
                                                            );
   
   
   
   function Test
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      LadenPrüfenExtern : in Boolean)
     return Boolean;
   
   function SichtbarkeitEinByte
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 VorhandeneSpeziesExtern <= 8
               and
                 (if
                        LadenPrüfenExtern
                          then
                    (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                     and
                       KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte))
              );
   
   function SichtbarkeitZweiByte
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 VorhandeneSpeziesExtern in 15 .. 16
               and
                 (if
                   LadenPrüfenExtern
                     then
                 (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                  and
                    KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte))
              );
   
   function SichtbarkeitVorzeichen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
               (VorhandeneSpeziesExtern in 9 .. 14
               or
                 VorhandeneSpeziesExtern in 17 .. 18)
               and
                 (if
                        LadenPrüfenExtern
                          then
                    (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                     and
                       KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte))
              );

end LadenSichtbarkeitLogik;
