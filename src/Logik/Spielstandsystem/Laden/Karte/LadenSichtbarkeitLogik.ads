with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenRecords;
with KartenDatentypen;
with SpeziesDatentypen;

private with ZahlenDatentypen;
private with SpeziesArrays;
private with SystemKonstanten;

with LeseWeltkarteneinstellungen;

package LadenSichtbarkeitLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   function Aufteilung
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.Speziesnummern;
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
   
   AktuellerArraybereich : ZahlenDatentypen.EigenesPositive;
   
   Potenz : ZahlenDatentypen.EigenerInteger;
   
   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;
   
   SichtbarkeitVorhanden : SystemDatentypenHTSEB.EinByte;
   
   SichtbarkeitVorhandenZweiByte : SystemDatentypenHTSEB.ZweiByte;
   
   SichtbarkeitVorhandenVorzeichen : SpeziesArrays.SoeziesSichtbarkeitVorzeichenArray;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   type SichtbarkeitGleichArray is array (SystemKonstanten.AllesUnsichtbar .. SystemKonstanten.AllesSichtbar) of Boolean;
   SichtbarkeitGleich : constant SichtbarkeitGleichArray := (
                                                             SystemKonstanten.AllesUnsichtbar => False,
                                                             SystemKonstanten.AllesSichtbar   => True
                                                            );
   
   
   
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
