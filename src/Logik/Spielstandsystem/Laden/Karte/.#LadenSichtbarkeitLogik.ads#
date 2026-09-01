with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenRecords;
with KartenDatentypen;
with SpeziesDatentypen;
with KartenArrays;

private with SpeziesArrays;
private with SystemKonstanten;

with LeseWeltkarteneinstellungen;

package LadenSichtbarkeitLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   function Felderreihe
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenArrays.SichtbarkeitKoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function AufteilungSpezieszeile
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
   
   type SichtbarkeitGleichArray is array (SystemKonstanten.AllesUnsichtbar .. SystemKonstanten.AllesSichtbar) of Boolean;
   SichtbarkeitGleich : constant SichtbarkeitGleichArray := (
                                                             SystemKonstanten.AllesUnsichtbar => False,
                                                             SystemKonstanten.AllesSichtbar   => True
                                                            );
   
   
   
   function FelderreiheLesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenArrays.SichtbarkeitKoordinatenArray;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
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
