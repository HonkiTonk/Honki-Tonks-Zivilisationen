with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenRecords;

private with KartenverbesserungDatentypen;
private with EinheitenRecords;
private with StadtRecords;
private with KartengrundDatentypen;
private with KartenextraDatentypen;

package LadenZusatzbelegungLogik is
   pragma Elaborate_Body;
   
   procedure Leersetzung;
   
   procedure KoordinatenSetzen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FelderanzahlExtern : in Positive);
   
   
   
   function Aufteilung
     (DateiLadenExtern : in File_Type;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
private
   
   VorhandeneFeldeffekte : SystemDatentypenHTSEB.EinByte;
   AktuellerFeldeffekt : SystemDatentypenHTSEB.EinByte;
   VorhandeneFeldelemente : SystemDatentypenHTSEB.EinByte;
   AktuellesFeldelement : SystemDatentypenHTSEB.EinByte;
   
   Potenz : SystemDatentypenHTSEB.EigenesNatural;
   
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;
   
   Feldeffekte : KartenRecords.FeldeffektArray;
   
   Fluss : KartenextraDatentypen.Fluss_Vorhanden_Enum;
   
   Ressource : KartenextraDatentypen.Ressourcen_Vorhanden_Enum;
   
   Weg : KartenverbesserungDatentypen.Weg_Vorhanden_Enum;
   
   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum;
   
   Einheit : EinheitenRecords.SpeziesEinheitnummerVorhandenRecord;
     
   Stadt : StadtRecords.SpeziesStadtnummerVorhandenRecord;
   
   type KoordinatenArray is array (SystemDatentypenHTSEB.AchtElemente'Range) of KartenRecords.KartenfeldNaturalRecord;
   Koordinaten : KoordinatenArray;
   
   
   
   function ZusatzgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function FlussEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function RessourceEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function WegEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function VerbesserungEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function StadtEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;
   
   function FeldeffekteEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KoordinatenArray;
      LadenPrüfenExtern : in Boolean)
      return Boolean;

end LadenZusatzbelegungLogik;
