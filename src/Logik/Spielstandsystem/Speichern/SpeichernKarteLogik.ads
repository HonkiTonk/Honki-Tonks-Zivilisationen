with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with KartenRecords;
private with EinheitenRecords;
private with StadtRecords;
private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean);
   
private
   
   Fluss : KartenextraDatentypen.Fluss_Enum;
   
   Ressource : KartenextraDatentypen.Ressourcen_Enum;
   
   Weg : KartenverbesserungDatentypen.Weg_Enum;
   
   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
   
   Feldeffekte : KartenRecords.FeldeffektArray;
   
   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
     
   Stadt : StadtRecords.SpeziesStadtnummerRecord;

end SpeichernKarteLogik;
