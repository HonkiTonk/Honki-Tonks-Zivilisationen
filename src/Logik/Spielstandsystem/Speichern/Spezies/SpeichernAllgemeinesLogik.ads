with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with SpeziesDatentypen;

package SpeichernAllgemeinesLogik is
   pragma Elaborate_Body;

   function Aufteilung
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

private

   SpeziesVorhanden : SpeziesDatentypen.Speziesnummern;
   AktuelleSpezies : SpeziesDatentypen.Speziesnummern;

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
