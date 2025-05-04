with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypen;

package SpeichernAllgemeinesLogik is
   pragma Elaborate_Body;

   function Allgemeines
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

private

   GewonnenWeiterspielen : SystemDatentypen.EinByte;
   BesiegtAktuell : SystemDatentypen.EinByte;
   Besiegt : SystemDatentypen.EinByte;



   function Speziesbelegung
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

end SpeichernAllgemeinesLogik;
