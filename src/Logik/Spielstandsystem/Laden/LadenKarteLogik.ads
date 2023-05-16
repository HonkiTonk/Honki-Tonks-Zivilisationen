with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with KartenRecords;
private with WeltkarteRecords;
private with KartenextraDatentypen;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with EinheitenRecords;
private with StadtRecords;

package LadenKarteLogik is
   pragma Elaborate_Body;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   Streamposition : Positive_Count;
   
   Fluss : KartenextraDatentypen.Fluss_Enum;
   
   Ressource : KartenextraDatentypen.Ressourcen_Enum;
   
   Weg : KartenverbesserungDatentypen.Weg_Enum;
   
   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
   
   Feldeffekte : KartenRecords.FeldeffektArray;
   
   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
     
   Stadt : StadtRecords.SpeziesStadtnummerRecord;
   
   ImmerVorhanden : WeltkarteRecords.ImmerVorhanden;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;

   Karteneintrag : WeltkarteRecords.WeltkarteRecord;
   
   
   
   function ZusatzgrundEinlesen
     (DateiLadenExtern : in File_Type)
      return KartengrundDatentypen.Zusatzgrund_Enum;
   
   function FeldeffekteEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenRecords.FeldeffektArray;
   
   function FlussEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenextraDatentypen.Fluss_Enum;
   
   function RessourceEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenextraDatentypen.Ressourcen_Enum;
   
   function WegEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenverbesserungDatentypen.Weg_Enum;
   
   function VerbesserungEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenverbesserungDatentypen.Verbesserung_Enum;
   
   function EinheitEinlesen
     (DateiLadenExtern : in File_Type)
      return EinheitenRecords.SpeziesEinheitnummerRecord;
   
   function StadtEinlesen
     (DateiLadenExtern : in File_Type)
      return StadtRecords.SpeziesStadtnummerRecord;

end LadenKarteLogik;
