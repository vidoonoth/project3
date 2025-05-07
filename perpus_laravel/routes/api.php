<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;


route::get('/test', function (){
    return response([
        'message' => 'is working'
    ], 200);
});

Route::post('/register', [RegisteredUserController::class, 'store'])
    ->name('register');
// Route::post('/login', [AuthenticatedSessionController::class, 'store'])
//     ->name('login')->middleware('api');;
// Route::middleware(['auth:sanctum'])->group(function () {
//     Route::get('/logout', [AuthenticatedSessionController::class, 'destroy'])
//         ->name('logout');
// });

Route::middleware('api')->group(function () {
    Route::post('/login', [AuthenticatedSessionController::class, 'store']);
    Route::post('/logout', [AuthenticatedSessionController::class, 'destroy'])->middleware('auth:sanctum');
});

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});