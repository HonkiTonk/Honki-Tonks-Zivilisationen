with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

package SpeichernAllgemeinesLogik is
   pragma Elaborate_Body;

   function Aufteilung
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

private

   GewonnenWeiterspielen : SystemDatentypenHTSEB.EinByte;
   BesiegtAktuell : SystemDatentypenHTSEB.EinByte;
   Besiegt : SystemDatentypenHTSEB.EinByte;



   function Allgemeines
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

   function Speziesbelegung
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

end SpeichernAllgemeinesLogik;
