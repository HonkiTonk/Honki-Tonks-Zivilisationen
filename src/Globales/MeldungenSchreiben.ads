pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package MeldungenSchreiben is

   procedure MeldungSchreiben
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 FehlermeldungExtern'Length > 0
              );
   
private

   DateiSpeichern : File_Type;

end MeldungenSchreiben;
